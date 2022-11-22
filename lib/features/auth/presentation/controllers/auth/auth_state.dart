import '../../../../../core/errors/failures.dart';
import '../../../data/entities/user_data.dart';

abstract class AuthState {}

class AuthLoadedState extends AuthState {
  final UserData data;

  AuthLoadedState(this.data);
}

class AuthErrorState extends AuthState {
  final AuthFailure failure;

  AuthErrorState(this.failure);
}

class AuthLoadingState extends AuthState {}

class AuthEmptyState extends AuthState {}
