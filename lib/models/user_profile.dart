import 'user_role.dart';

class UserProfile {
  final String id;
  final String displayName;
  final UserRole role;

  UserProfile({
    required this.id,
    required this.displayName,
    required this.role,
  });
}