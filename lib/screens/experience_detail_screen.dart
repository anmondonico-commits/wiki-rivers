import 'package:flutter/material.dart';
import '../models/river_experience.dart';
import '../utils/date_utils.dart';

class ExperienceDetailScreen extends StatelessWidget {
  final RiverExperience experience;

  const ExperienceDetailScreen({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dettaglio Discesa')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (experience.hasWarning)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning, color: Colors.orange),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'SEGNALAZIONE PERICOLO:\n${experience.warningText}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            Text('Data discesa: ${RiverDateUtils.formatDate(experience.descentDate)}'),
            const SizedBox(height: 8),
            Text('Kayaker: ${experience.userDisplayName}'),
            Text('Livello acqua: ${experience.waterLevel}'),
            const Divider(height: 40),
            const Text('Note:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 10),
            Text(experience.notes, style: const TextStyle(fontSize: 16, height: 1.5)),
            const SizedBox(height: 40),
            Text(
              'Registrata il: ${RiverDateUtils.formatDate(experience.createdAt)}',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}