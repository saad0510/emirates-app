import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/utils/base_change_notifier.dart';
import '../../data/entities/city.dart';
import '../../data/repositories/city_repo.dart';
import '../../datasources/models/city_model.dart';

class CityController extends BaseChangeNotifier<bool> {
  final CityRepo repo;

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

  Future<List<Destination>> getPopularDestinations([int limit = 3]) async {
    state = true;
    final List x = await Supabase.instance.client.rpc('popular_destinations');
    final dests = x.map((e) => DestinationModel.fromMap(e)).toList();
    state = false;
    return dests;
  }
}
