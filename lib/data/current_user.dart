import '../models/user_profile.dart';
import '../models/user_role.dart';

class CurrentUser {
  // Simulazione utente loggato
  static final UserProfile session = UserProfile(
    id: 'u1',
    displayName: 'AndreRock',
    role: UserRole.admin,
  );
}