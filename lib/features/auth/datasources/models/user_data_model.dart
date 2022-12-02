import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/entities/user_data.dart';

class UserDataModel extends UserData {
  const UserDataModel({
    required super.uid,
    required super.name,
    required super.email,
    required super.birthDate,
  });

  factory UserDataModel.fromUserData(UserData data) {
    return UserDataModel(
      uid: data.uid,
      email: data.email,
      name: data.name,
      birthDate: data.birthDate,
    );
  }

  factory UserDataModel.fromSupabaseUser(User user) {
    final str = user.userMetadata?['dob']! as String;
    final year = int.tryParse(str.substring(0, 4))!;
    final month = int.tryParse(str.substring(5, 7))!;
    final day = int.tryParse(str.substring(8, 10))!;

    return UserDataModel(
      uid: user.id,
      name: user.userMetadata?['name'] ?? 'no name',
      email: user.email!,
      birthDate: DateTime(year, month, day),
    );
  }

  Map<String, dynamic> toSupabaseMetadata() {
    return {
      'name': name,
      'dob': '$birthDate'.substring(0, 10),
    };
  }
}
