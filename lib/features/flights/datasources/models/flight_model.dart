import '../../../../core/utils/date_time_service.dart';
import '../../data/entities/flight.dart';
import 'city_model.dart';

class FlightModel extends Flight {
  const FlightModel({
    required super.fid,
    required super.rowSize,
    required super.economyRows,
    required super.businessRows,
    required super.economyCost,
    required super.businesCost,
    required super.arrivalCity,
    required super.departureCity,
    required super.arrivalTime,
    required super.departureTime,
  });

  factory FlightModel.fromFlight(Flight flight) {
    return FlightModel(
      fid: flight.fid,
      rowSize: flight.rowSize,
      economyRows: flight.economyRows,
      businessRows: flight.businessRows,
      economyCost: flight.economyCost,
      businesCost: flight.businesCost,
      arrivalCity: flight.arrivalCity,
      departureCity: flight.departureCity,
      arrivalTime: flight.arrivalTime,
      departureTime: flight.departureTime,
    );
  }

  factory FlightModel.fromMapSearched(
    Map<String, dynamic> map,
    CityModel departureCity,
    CityModel arrivalCity,
  ) {
    return FlightModel(
      fid: map['fid'],
      rowSize: map['seats_per_row'],
      economyRows: map['economy_rows'],
      businessRows: map['business_rows'],
      economyCost: (map['economy_cost'] as int).toDouble(),
      businesCost: (map['business_cost'] as int).toDouble(),
      arrivalCity: arrivalCity,
      departureCity: departureCity,
      arrivalTime: DateTimeService.fromIsoString(map['arrival_time']),
      departureTime: DateTimeService.fromIsoString(map['departure_time']),
    );
  }

  factory FlightModel.fromMap(Map<String, dynamic> map) {
    return FlightModel(
      fid: map['fid'],
      rowSize: map['seats_per_row'],
      economyRows: map['economy_rows'],
      businessRows: map['business_rows'],
      economyCost: (map['economy_cost'] as int).toDouble(),
      businesCost: (map['business_cost'] as int).toDouble(),
      arrivalCity: CityModel.fromMap(map['arrival_city_data']),
      departureCity: CityModel.fromMap(map['departure_city_data']),
      arrivalTime: DateTimeService.fromIsoString(map['arrival_time']),
      departureTime: DateTimeService.fromIsoString(map['departure_time']),
    );
  }
}
