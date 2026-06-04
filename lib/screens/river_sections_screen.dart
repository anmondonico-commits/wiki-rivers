import 'package:flutter/material.dart';
import '../models/river.dart';
import '../widgets/river_section_card.dart';
import 'river_section_detail_screen.dart';

class RiverSectionsScreen extends StatelessWidget {
  final River river;

  const RiverSectionsScreen({super.key, required this.river});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(river.name)),
      body: river.sections.isEmpty
          ? const Center(child: Text('Nessun tratto disponibile.'))
          : ListView.builder(
              itemCount: river.sections.length,
              itemBuilder: (context, index) {
                final section = river.sections[index];
                return RiverSectionCard(
                  section: section,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RiverSectionDetailScreen(section: section, riverId: river.id)),
                  ),
                );
              },
            ),
    );
  }
}