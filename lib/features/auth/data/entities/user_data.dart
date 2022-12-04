class UserData {
  final String uid;
  final String name;
  final String email;
  final DateTime birthDate;

  const UserData({
    required this.uid,
    required this.name,
    required this.email,
    required this.birthDate,
  });

  int get age {
    return DateTime.now().difference(birthDate).inDays ~/ (30 * 12);
  }
}
