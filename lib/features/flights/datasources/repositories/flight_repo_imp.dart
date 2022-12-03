import 'package:multiple_result/multiple_result.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../data/entities/city.dart';
import '../../data/entities/seat.dart';
import '../../data/repositories/flight_repo.dart';
import '../models/city_model.dart';
import '../models/flight_model.dart';
import '../models/seat_model.dart';
import '../sources/flight_remote_src.dart';

class FlightRepoImp implements FlightRepo {
  final FlightRemoteSrc remoteSrc;

  FlightRepoImp({required this.remoteSrc});

  @override
  Future<Result<FlightFailure, Iterable<FlightModel>>> search(
    City departureCity,
    City arrivalCity,
  ) async {
    try {
      final flights = await remoteSrc.search(
        CityModel.fromCity(departureCity),
        CityModel.fromCity(arrivalCity),
      );
      return Success(flights);
    } on FlightException catch (e) {
      return Error(FlightFailure(e.message));
    }
  }

  @override
  Result<FlightFailure, Stream<Iterable<Seat>>> listenSeatsFor(String fid) {
    try {
      final stream = remoteSrc.seatsOf(fid);
      return Success(stream);
    } on FlightException catch (e) {
      return Error(FlightFailure(e.message));
    }
  }

  @override
  Future<Result<FlightFailure, Void>> reserveSeat(Seat seat) async {
    try {
      await remoteSrc.reserveSeat(
        SeatModel.fromSeat(seat),
      );
      return const Success(success);
    } on FlightException catch (e) {
      return Error(FlightFailure(e.message));
    }
  }

  @override
  Future<Result<FlightFailure, Void>> cancelSeat(Seat seat) async {
    try {
      await remoteSrc.cancelSeat(
        SeatModel.fromSeat(seat),
      );
      return const Success(success);
    } on FlightException catch (e) {
      return Error(FlightFailure(e.message));
    }
  }
}
