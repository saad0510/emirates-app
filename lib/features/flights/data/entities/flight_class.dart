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

  factory FlightClass.fromName(String name) {
    switch (name) {
      case 'Business':
        return FlightClass.business;
      case 'Economy':
        return FlightClass.economy;
      default:
        throw 'Wrong Name';
    }
  }
  factory FlightClass.fromId(String seatId) {
    switch (seatId.substring(0, 1)) {
      case 'B':
        return FlightClass.business;
      case 'E':
        return FlightClass.economy;
      default:
        throw 'Wrong Name';
    }
  }

  String get prefix => name.substring(0, 1);
}
