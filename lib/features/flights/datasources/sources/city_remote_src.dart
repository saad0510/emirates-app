import '../models/city_model.dart';

abstract class CityRemoteSrc {
  Future<Iterable<CityModel>> search(String cityName);
}
