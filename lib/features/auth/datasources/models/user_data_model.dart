import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/entities/user_data.dart';

class UserDataModel extends UserData {
  const UserDataModel({
    required super.name,
    required super.email,
  });

  factory UserDataModel.fromUserData(UserData data) {
    return UserDataModel(
      email: data.email,
      name: data.name,
    );
  }

  factory UserDataModel.fromSupabaseUser(User user) {
    return UserDataModel(
      name: user.userMetadata?['name'] ?? 'no name',
      email: user.email!,
    );
  }
}
