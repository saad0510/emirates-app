class City {
  final String code;
  final String name;
  final String airport;
  final String country;

  const City({
    required this.code,
    required this.name,
    required this.airport,
    required this.country,
  });

  const City.empty()
      : code = '',
        name = '',
        airport = '',
        country = '';

  String get fullname => "$name, $country";
}

class Destination extends City {
  final String image;

  const Destination({
    required super.code,
    required super.name,
    required super.airport,
    required super.country,
    required this.image,
  });
}
