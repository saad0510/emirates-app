import '../../../../core/utils/base_change_notifier.dart';
import '../../data/entities/city.dart';
import '../../data/repositories/city_repo.dart';

class CityController extends BaseChangeNotifier<bool> {
  final CityRepo repo;

  // TODO: remove this
  static const List<City> cities = [
    City(code: 'ISL', name: 'Islamabad', airport: 'Islamabad International Airport', country: 'Pakistan'),
  ];

  CityController({required this.repo}) : super(false);

  Future<Iterable<City>> search(String city) async {
    final res = await repo.search(city);
    if (res.isSuccess()) {
      return res.getSuccess()!;
    }

    final error = res.getError()!;
    return [
      City(
        code: error.name,
        name: 'An error occured',
        airport: error.message,
        country: '',
      ),
    ];
  }
}
