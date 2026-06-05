import 'river_section.dart';

class River {
  final String id;
  final String name;
  final String country;
  final String description; // Nuovo campo
  final List<RiverSection> sections;

  River({
    required this.id,
    required this.name,
    required this.country,
    this.description = '', // Default per compatibilità mock
    required this.sections,
  });

  int get sectionCount => sections.length;

  DateTime get latestUpdate {
    if (sections.isEmpty) return DateTime(2000, 1, 1);
    return sections
        .map((s) => s.lastUpdated)
        .reduce((a, b) => a.isAfter(b) ? a : b);
  }

  int get minDifficulty {
    if (sections.isEmpty) return 0;
    return sections.map((s) => s.difficulty).reduce((a, b) => a < b ? a : b);
  }

  int get maxDifficulty {
    if (sections.isEmpty) return 0;
    return sections.map((s) => s.difficulty).reduce((a, b) => a > b ? a : b);
  }
}