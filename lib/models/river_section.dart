class RiverSection {
  final String id;
  final String name;
  final int difficulty;
  final String shortDescription;
  final String longDescription;
  final DateTime lastUpdated;
  final String updatedBy;

  RiverSection({
    required this.id,
    required this.name,
    required this.difficulty,
    required this.shortDescription,
    required this.longDescription,
    required this.lastUpdated,
    required this.updatedBy,
  });
}