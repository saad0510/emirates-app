import 'package:multiple_result/multiple_result.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../data/entities/city.dart';
import '../../data/repositories/city_repo.dart';
import '../sources/city_remote_src.dart';

class CityRepoImp implements CityRepo {
  final CityRemoteSrc remoteSrc;

  CityRepoImp({required this.remoteSrc});

  @override
  Future<Result<CityFailure, Iterable<City>>> search(String cityName) async {
    try {
      final cities = await remoteSrc.search(cityName);
      return Success(cities);
    } on CityException catch (e) {
      return Error(CityFailure(e.name, e.message));
    }
  }
}
