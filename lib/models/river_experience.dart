class RiverExperience {
  final String id;
  final String riverId;
  final String sectionId;
  final String userId;
  final String userDisplayName;
  final DateTime descentDate;
  final String waterLevel;
  final String notes;
  final bool hasWarning;
  final String? warningText;
  final DateTime createdAt;

  RiverExperience({
    required this.id,
    required this.riverId,
    required this.sectionId,
    required this.userId,
    required this.userDisplayName,
    required this.descentDate,
    required this.waterLevel,
    required this.notes,
    required this.hasWarning,
    this.warningText,
    required this.createdAt,
  });
}