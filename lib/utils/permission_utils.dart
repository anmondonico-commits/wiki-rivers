import '../models/user_profile.dart';
import '../models/user_role.dart';

class PermissionUtils {
  static bool canCreateExperience(UserProfile user) {
    return user.role == UserRole.contributor || 
           user.role == UserRole.editor || 
           user.role == UserRole.admin;
  }

  // --- Nuovi Permessi Fase 4 ---

  static bool canCreateRiver(UserProfile user) {
    return user.role == UserRole.admin;
  }

  static bool canCreateSection(UserProfile user) {
    return user.role == UserRole.admin || user.role == UserRole.editor;
  }

  static bool canEditSection(UserProfile user) {
    return user.role == UserRole.admin || user.role == UserRole.editor;
  }
}