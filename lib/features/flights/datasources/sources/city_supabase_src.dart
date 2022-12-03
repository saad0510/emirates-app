import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/city_model.dart';
import 'city_remote_src.dart';

class CitySupabaseSrc implements CityRemoteSrc {
  static const tableName = 'cities';

  final SupabaseClient client;

  CitySupabaseSrc({required this.client});

  @override
  Future<Iterable<CityModel>> search(String cityName) async {
    try {
      final query = client //
          .from(tableName)
          .select()
          .ilike('name', '$cityName%');

      final List cities = await query;
      return cities.map((e) => CityModel.fromMap(e));
    } on PostgrestException catch (e) {
      log('search: $e', name: 'CitySupabaseSrc');

      throw CityException(cityName, e.message);
    } catch (e) {
      log('search: $e', name: 'CitySupabaseSrc');
      rethrow;
    }
  }

  @override
  Future<CityModel> fetchCity(String code) async {
    try {
      final query = client //
          .from(tableName)
          .select()
          .eq('code', code)
          .single();

      final Map<String, dynamic> city = await query;
      return CityModel.fromMap(city);
    } on PostgrestException catch (e) {
      log('fetchCity: $e', name: 'CitySupabaseSrc');
      throw CityException(code, e.message);
    } catch (e) {
      log('fetchCity: $e', name: 'CitySupabaseSrc');
      rethrow;
    }
  }
}
