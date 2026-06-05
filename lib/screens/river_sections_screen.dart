import 'package:flutter/material.dart';
import '../models/river.dart';
import '../models/river_section.dart';
import '../data/current_user.dart';
import '../utils/permission_utils.dart';
import '../widgets/river_section_card.dart';
import 'river_section_detail_screen.dart';
import 'edit_river_section_screen.dart';

class RiverSectionsScreen extends StatefulWidget {
  final River river;
  const RiverSectionsScreen({super.key, required this.river});

  @override
  State<RiverSectionsScreen> createState() => _RiverSectionsScreenState();
}

class _RiverSectionsScreenState extends State<RiverSectionsScreen> {
  void _addSection() async {
    final newSection = await Navigator.push<RiverSection>(
      context,
      MaterialPageRoute(builder: (_) => const EditRiverSectionScreen()),
    );
    if (newSection != null) {
      setState(() {
        widget.river.sections.add(newSection);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.river.name)),
      body: ListView.builder(
        itemCount: widget.river.sections.length,
        itemBuilder: (context, index) => RiverSectionCard(
          section: widget.river.sections[index],
          onTap: () => Navigator.push(
            context, 
            MaterialPageRoute(builder: (_) => RiverSectionDetailScreen(section: widget.river.sections[index], riverId: widget.river.id))
          ).then((_) => setState(() {})),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: PermissionUtils.canCreateSection(CurrentUser.session) ? _addSection : null,
        backgroundColor: PermissionUtils.canCreateSection(CurrentUser.session) ? Colors.teal : Colors.grey,
        icon: const Icon(Icons.add_location_alt),
        label: const Text('Nuovo Tratto'),
      ),
    );
  }
}