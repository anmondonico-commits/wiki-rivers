class DifficultyUtils {
  static String toWW(int level) {
    switch (level) {
      case 1: return 'WW I';
      case 2: return 'WW II';
      case 3: return 'WW III';
      case 4: return 'WW IV';
      case 5: return 'WW V';
      case 6: return 'WW VI';
      default: return 'N/A';
    }
  }

  static String toWWRange(int min, int max) {
    if (min == 0) return 'N/D';
    if (min == max) return toWW(min);
    return '${toWW(min)}-${toWW(max).replaceFirst('WW ', '')}';
  }
}