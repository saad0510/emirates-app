import 'package:multiple_result/multiple_result.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../data/entities/city.dart';
import '../../data/repositories/flight_repo.dart';
import '../models/city_model.dart';
import '../models/flight_model.dart';
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
}
