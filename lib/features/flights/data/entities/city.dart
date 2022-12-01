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

  String get fullname => "$name, $country";
}
