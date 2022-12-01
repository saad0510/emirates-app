// ignore_for_file: constant_identifier_names

import '../../data/entities/city.dart';

class CityModel extends City {
  static const table = 'cities';
  static const code_col = 'code';
  static const name_col = 'name';
  static const country_col = 'country';
  static const airport_col = 'airport';

  CityModel({
    required super.code,
    required super.name,
    required super.airport,
    required super.country,
  });

  factory CityModel.fromCity(City city) {
    return CityModel(
      code: city.code,
      name: city.name,
      airport: city.airport,
      country: city.country,
    );
  }
  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      code: map[code_col],
      name: map[name_col],
      airport: map[airport_col],
      country: map[country_col],
    );
  }
}
