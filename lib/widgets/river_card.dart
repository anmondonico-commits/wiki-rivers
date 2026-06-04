import 'package:flutter/material.dart';
import '../models/river.dart';
import '../utils/difficulty_utils.dart';
import '../utils/date_utils.dart';

class RiverCard extends StatelessWidget {
  final River river;
  final VoidCallback onTap;

  const RiverCard({super.key, required this.river, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        onTap: onTap,
        title: Text(river.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${river.country} • ${river.sectionCount} tratti\nRange: ${DifficultyUtils.toWWRange(river.minDifficulty, river.maxDifficulty)}'),
        trailing: river.sections.isNotEmpty 
            ? Text(RiverDateUtils.formatDate(river.latestUpdate), style: const TextStyle(fontSize: 12))
            : null,
        isThreeLine: true,
      ),
    );
  }
}