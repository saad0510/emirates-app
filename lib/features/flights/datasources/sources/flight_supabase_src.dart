import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/city_model.dart';
import '../models/flight_model.dart';
import 'flight_remote_src.dart';

class FlightSupabaseSrc implements FlightRemoteSrc {
  static const tableName = 'flights';

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
          .match({
        'departure_city': departureCity.code,
        'arrival_city': arrivalCity.code,
      });

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
}
