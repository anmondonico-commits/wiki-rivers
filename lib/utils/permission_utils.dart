import '../models/user_profile.dart';
import '../models/user_role.dart';

class PermissionUtils {
  static bool canCreateExperience(UserProfile user) {
    // Per ora tutti i ruoli definiti possono creare Experience
    return user.role == UserRole.contributor || 
           user.role == UserRole.editor || 
           user.role == UserRole.admin;
  }
}