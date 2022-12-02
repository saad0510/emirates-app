import 'package:multiple_result/multiple_result.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../data/entities/user_data.dart';
import '../../data/repositories/auth_repo.dart';
import '../models/user_data_model.dart';
import '../sources/auth_remote_src.dart';

class AuthRepoImp implements AuthRepo {
  final AuthRemoteSrc remoteSrc;

  AuthRepoImp({required this.remoteSrc});

  @override
  Future<Result<AuthFailure, UserData>> login(String email, String password) async {
    try {
      final UserData userData = await remoteSrc.login(email, password);
      return Success(userData);
    } on AuthException catch (e) {
      return Error(AuthFailure(e.message));
    }
  }

  @override
  Future<Result<AuthFailure, Void>> register(UserData data, String password) async {
    try {
      await remoteSrc.register(
        UserDataModel.fromUserData(data),
        password,
      );
      return const Success(success);
    } on AuthException catch (e) {
      return Error(AuthFailure(e.message));
    }
  }

  @override
  Future<Result<AuthFailure, UserData>> silentLogin() async {
    try {
      bool isLoggedIn = await remoteSrc.isLoggedIn;
      if (!isLoggedIn) {
        return const Error(AuthFailure('No login session found'));
      }
      return Success(await remoteSrc.currentUser);
    } on AuthException catch (e) {
      return Error(AuthFailure(e.message));
    }
  }

  @override
  Future<Result<AuthFailure, Void>> logout() async {
    try {
      await remoteSrc.logout();
      return const Success(success);
    } on AuthException catch (e) {
      return Error(AuthFailure(e.message));
    }
  }
}
