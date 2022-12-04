import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/city_model.dart';
import '../models/flight_model.dart';
import '../models/seat_model.dart';
import 'flight_remote_src.dart';

class FlightSupabaseSrc implements FlightRemoteSrc {
  static const tableName = 'flights';
  static const seatsTableName = 'seats';

  final SupabaseClient client;

  FlightSupabaseSrc({required this.client});

  @override
  Future<Iterable<FlightModel>> search(
    CityModel departureCity,
    CityModel arrivalCity,
  ) async {
    try {
      final query = client
          .from(tableName) //
          .select()
          .gt('departure_time', DateTime.now().toIso8601String())
          .match({
        'departure_city': departureCity.code,
        'arrival_city': arrivalCity.code,
      }).order('departure_time', ascending: true);

      final List flights = await query;
      return flights.map(
        (e) => FlightModel.fromMapSearched(e, departureCity, arrivalCity),
      );
    } on PostgrestException catch (e) {
      log('search: $e', name: 'FlightSupabaseSrc');
      throw FlightException(e.message);
    } catch (e) {
      log('search: $e', name: 'FlightSupabaseSrc');
      rethrow;
    }
  }

  @override
  Stream<Iterable<SeatModel>> seatsOf(String fid) {
    try {
      final stream = client.from(seatsTableName) //
          .stream(primaryKey: ['fid', 'seat_no']) //
          .eq('fid', fid);

      return stream.asyncMap(
        (seats) => seats.map((e) => SeatModel.fromMap(e)),
      );
    } on PostgrestException catch (e) {
      log('seatsOf: $e', name: 'FlightSupabaseSrc');
      throw FlightException(e.message);
    } catch (e) {
      log('seatsOf: $e', name: 'FlightSupabaseSrc');
      rethrow;
    }
  }

  @override
  Future<void> reserveSeat(SeatModel seatModel) async {
    try {
      final query = client.from(seatsTableName).insert(seatModel.toMap());
      await query;
    } on PostgrestException catch (e) {
      log('seatsOf: $e', name: 'FlightSupabaseSrc');
      throw FlightException(e.message);
    } catch (e) {
      log('seatsOf: $e', name: 'FlightSupabaseSrc');
      rethrow;
    }
  }

  @override
  Future<void> cancelSeat(SeatModel seatModel) async {
    try {
      final query = client
          .from(seatsTableName) //
          .delete()
          .match({
        'fid': seatModel.flightId,
        'seat_no': seatModel.seatNo,
      });
      await query;
    } on PostgrestException catch (e) {
      log('seatsOf: $e', name: 'FlightSupabaseSrc');
      throw FlightException(e.message);
    } catch (e) {
      log('seatsOf: $e', name: 'FlightSupabaseSrc');
      rethrow;
    }
  }
}
