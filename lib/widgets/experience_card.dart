import 'package:flutter/material.dart';
import '../models/river_experience.dart';
import '../utils/date_utils.dart';

class ExperienceCard extends StatelessWidget {
  final RiverExperience experience;
  final VoidCallback onTap;

  const ExperienceCard({super.key, required this.experience, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          experience.hasWarning ? Icons.warning_amber_rounded : Icons. kayaking,
          color: experience.hasWarning ? Colors.orange : Colors.teal,
        ),
        title: Text(RiverDateUtils.formatDate(experience.descentDate)),
        subtitle: Text(
          'Da: ${experience.userDisplayName}\nLivello: ${experience.waterLevel}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.chevron_right),
        isThreeLine: true,
      ),
    );
  }
}