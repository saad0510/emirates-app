import '../../../../../core/utils/base_change_notifier.dart';
import '../../../data/entities/user_data.dart';
import '../../../data/repositories/auth_repo.dart';
import 'auth_state.dart';

class AuthController extends BaseChangeNotifier<AuthState> {
  final AuthRepo repo;

  AuthController({required this.repo}) : super(AuthEmptyState(), debugMode: true);

  @override
  Future<void> init() async {
    state = AuthLoadingState();
    final res = await repo.silentLogin();
    res.when(
      (error) => state = AuthEmptyState(),
      (data) => state = AuthLoadedState(data),
    );
    await super.init();
  }

  UserData get user {
    if (state is AuthLoadedState) {
      return (state as AuthLoadedState).data;
    }
    return UserData(
      uid: '',
      name: 'no name',
      email: 'no@email.com',
      birthDate: DateTime.now(),
    );
  }

  void login(String email, String password) async {
    state = AuthLoadingState();

    final res = await repo.login(email, password);

    res.when(
      (failure) => state = AuthErrorState(failure),
      (data) => state = AuthLoadedState(data),
    );
  }

  void register(UserData data, String password) async {
    state = AuthLoadingState();

    final res = await repo.register(data, password);

    res.when(
      (failure) => state = AuthErrorState(failure),
      (success) => state = AuthLoadedState(data),
    );
  }

  void logout() async {
    state = AuthLoadingState();

    final res = await repo.logout();

    res.when(
      (failure) => state = AuthErrorState(failure),
      (success) => state = AuthEmptyState(),
    );
  }
}
