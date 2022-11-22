import '../../data/entities/user_data.dart';
import '../models/user_data_model.dart';

abstract class AuthRemoteSrc {
  Future<UserData> get currentUser;

  Future<bool> get isLoggedIn;

  Future<UserDataModel> login(
    String email,
    String password,
  );

  Future<void> register(
    UserDataModel data,
    String password,
  );

  Future<void> logout();
}
