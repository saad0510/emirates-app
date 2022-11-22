import 'package:multiple_result/multiple_result.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user_data.dart';

abstract class AuthRepo {
  /// Logs in the user with given `email`
  Future<Result<AuthFailure, UserData>> login(
    String email,
    String password,
  );

  /// Register a new user with given `UserData`
  Future<Result<AuthFailure, Void>> register(
    UserData data,
    String password,
  );

  /// Checks current session and pretends to login
  /// only if user is already logged in
  Future<Result<AuthFailure, UserData>> silentLogin();

  /// Ends the current login session
  Future<Result<AuthFailure, Void>> logout();
}
