import 'package:multiple_result/multiple_result.dart';

import '../../../../core/errors/failures.dart';
import '../entities/city.dart';

abstract class CityRepo {
  /// returns all cities whose name start with given string
  Future<Result<CityFailure, Iterable<City>>> search(String cityName);

  /// fetches the given city
  Future<Result<CityFailure, City>> fetchCity(String code);
}
