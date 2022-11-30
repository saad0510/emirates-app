enum FlightClass {
  business,
  economy;

  String get name {
    switch (this) {
      case FlightClass.business:
        return 'Business';
      case FlightClass.economy:
        return 'Economy';
      default:
        return 'None';
    }
  }

  String get prefix => name.substring(0, 1);
}
