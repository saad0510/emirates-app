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

  factory FlightModel.fromMapSearched(
    Map<String, dynamic> map,
    CityModel departureCity,
    CityModel arrivalCity,
  ) {
    return FlightModel(
      fid: map['fid'],
      rowSize: map['rows_per_seat'],
      economyRows: map['economy_rows'],
      businessRows: map['business_rows'],
      economyCost: (map['economy_cost'] as int).toDouble(),
      businesCost: (map['business_cost'] as int).toDouble(),
      arrivalCity: departureCity,
      departureCity: arrivalCity,
      arrivalTime: DateTimeService.fromIsoString(map['arrival_time']),
      departureTime: DateTimeService.fromIsoString(map['departure_time']),
    );
  }
}
