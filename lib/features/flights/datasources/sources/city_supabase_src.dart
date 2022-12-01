import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/city_model.dart';
import 'city_remote_src.dart';

class CitySupabaseSrc extends CityRemoteSrc {
  final SupabaseClient client;

  CitySupabaseSrc({required this.client});

  @override
  Future<Iterable<CityModel>> search(String cityName) async {
    try {
      final query = client //
          .from(CityModel.table)
          .select()
          .ilike(CityModel.name_col, '$cityName%');

      final List cities = await query;
      return cities.map((e) => CityModel.fromMap(e));
    } on PostgrestException catch (e) {
      log('search: $e', name: 'CitySupabaseSrc');

      throw CityException(cityName, e.message);
    }
  }
}
