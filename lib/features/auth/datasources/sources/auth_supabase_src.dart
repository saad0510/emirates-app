import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exceptions.dart' as err;
import '../../data/entities/user_data.dart';
import '../models/user_data_model.dart';
import 'auth_remote_src.dart';

class AuthSupabaseSrc implements AuthRemoteSrc {
  final SupabaseClient client;

  AuthSupabaseSrc({required this.client});

  @override
  Future<UserData> get currentUser async {
    return UserDataModel.fromSupabaseUser(client.auth.currentUser!);
  }

  @override
  Future<bool> get isLoggedIn async {
    return client.auth.currentSession != null;
  }

  @override
  Future<UserDataModel> login(String email, String password) async {
    try {
      final res = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (res.session == null || res.user == null) {
        throw err.AuthException(
          'signInWithPassword($email, $password)',
          'session or user was null after the call',
        );
      }

      return UserDataModel.fromSupabaseUser(res.user!);
    } on AuthException catch (e) {
      log('signInWithPassword: $e', name: 'AuthSupabaseSrc');

      throw err.AuthException(
        e.statusCode ?? 'signInWithPassword($email, $password)',
        e.message,
      );
    } catch (e) {
      log('signInWithPassword: $e', name: 'AuthSupabaseSrc');
      rethrow;
    }
  }

  @override
  Future<void> register(UserDataModel data, String password) async {
    try {
      final res = await client.auth.signUp(
        email: data.email,
        data: data.toSupabaseMetadata(),
        password: password,
      );

      if (res.session == null || res.user == null) {
        throw err.AuthException(
          'signUp($data, $password)',
          'session or user was null after the call',
        );
      }
    } on AuthException catch (e) {
      log('signUp: $e', name: 'AuthSupabaseSrc');

      throw err.AuthException(
        e.statusCode ?? 'signUp($data, $password)',
        e.message,
      );
    } catch (e) {
      log('signUp: $e', name: 'AuthSupabaseSrc');
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await client.auth.signOut();
    } on AuthException catch (e) {
      log('signOut: $e', name: 'AuthSupabaseSrc');

      throw err.AuthException(
        e.statusCode ?? 'signOut()',
        e.message,
      );
    } catch (e) {
      log('signOut: $e', name: 'AuthSupabaseSrc');
      rethrow;
    }
  }
}
