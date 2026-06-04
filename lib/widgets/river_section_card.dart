import 'package:flutter/material.dart';
import '../models/river_section.dart';
import '../utils/difficulty_utils.dart';
import '../utils/date_utils.dart';

class RiverSectionCard extends StatelessWidget {
  final RiverSection section;
  final VoidCallback onTap;

  const RiverSectionCard({super.key, required this.section, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Colors.teal,
          child: Text(
            DifficultyUtils.toWW(section.difficulty).replaceFirst('WW ', ''),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(section.name),
        subtitle: Text('Aggiornato il: ${RiverDateUtils.formatDate(section.lastUpdated)}\nda: ${section.updatedBy}'),
      ),
    );
  }
}