class City {
  final String name;
  final String code;
  final String country;

  const City({
    required this.name,
    required this.code,
    required this.country,
  });

  String get fullname => "$name, $country";
}
