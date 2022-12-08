import '../../data/entities/city.dart';

class CityModel extends City {
  const CityModel({
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
      code: map['code'],
      name: map['name'],
      airport: map['airport'],
      country: map['country'],
    );
  }
}

class DestinationModel extends Destination {
  const DestinationModel({
    required super.code,
    required super.name,
    required super.airport,
    required super.country,
    required super.image,
  });

  factory DestinationModel.fromMap(Map<String, dynamic> map) {
    return DestinationModel(
      code: map['code'],
      name: map['name'],
      airport: map['airport'],
      country: map['country'],
      image: map['image_url'],
    );
  }
}
