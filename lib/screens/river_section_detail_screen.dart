import 'package:flutter/material.dart';
import '../models/river_section.dart';
import '../models/river_experience.dart';
import '../data/mock_experiences.dart';
import '../data/current_user.dart';
import '../utils/difficulty_utils.dart';
import '../utils/date_utils.dart';
import '../utils/permission_utils.dart';
import '../widgets/experience_card.dart';
import 'add_experience_screen.dart';
import 'experience_detail_screen.dart';
import 'edit_river_section_screen.dart';


class RiverSectionDetailScreen extends StatefulWidget {
  final RiverSection section;
  // Aggiunto riverId per collegare le experience
  final String riverId; 

  const RiverSectionDetailScreen({
    super.key, 
    required this.section, 
    required this.riverId,
  });

  @override
  State<RiverSectionDetailScreen> createState() => _RiverSectionDetailScreenState();
}

//class _RiverSectionDetailScreenState extends State<RiverSectionDetailScreen> {
//  late List<RiverExperience> _experiences;

class _RiverSectionDetailScreenState extends State<RiverSectionDetailScreen> {
  late List<RiverExperience> _localExperiences;

/*
  @override
  void initState() {
    super.initState();
    // Filtra le experience mock per questo tratto
    _experiences = MockExperiences.get()
        .where((e) => e.sectionId == widget.section.id)
        .toList();
    // Ordina per data decrescente
    _experiences.sort((a, b) => b.descentDate.compareTo(a.descentDate));
  }
*/

  @override
  void initState() {
    super.initState();
    _loadExperiences();
  }

void _loadExperiences() {
    // Carichiamo dalla lista statica globale
    setState(() {
      _localExperiences = MockExperiences.items
          .where((e) => e.sectionId == widget.section.id)
          .toList();
      _localExperiences.sort((a, b) => b.descentDate.compareTo(a.descentDate));
    });
  }

  void _addNewExperience() async {
    final result = await Navigator.push<RiverExperience>(
      context,
      MaterialPageRoute(
        builder: (_) => AddExperienceScreen(
          riverId: widget.riverId,
          sectionId: widget.section.id,
        ),
      ),
    );

    if (!mounted) return;

    if (result != null) {
      // PUNTO CHIAVE: Salviamo nella lista globale prima di aggiornare la UI
      MockExperiences.add(result);
      
      // Ricarichiamo la lista locale per mostrare il nuovo elemento
      _loadExperiences();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Experience salvata con successo')),
      );
    }
  }


/*
  void _addNewExperience() async {
    final result = await Navigator.push<RiverExperience>(
      context,
      MaterialPageRoute(
        builder: (_) => AddExperienceScreen(
          riverId: widget.riverId,
          sectionId: widget.section.id,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _experiences.insert(0, result); // Aggiunge in cima alla lista
      });
    }
  }
*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(widget.section.name)),
      appBar: AppBar(
        title: Text(widget.section.name),
      actions: [
        if (PermissionUtils.canEditSection(CurrentUser.session))
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Modifica Tratto',
            onPressed: _editSection, // Qui è dove viene "referenziato" il metodo
          ),
      ],
    ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // INFO TRATTO (Fase 1)
            Text(
              DifficultyUtils.toWW(widget.section.difficulty),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const SizedBox(height: 8),
            Text('Aggiornato da ${widget.section.updatedBy} il ${RiverDateUtils.formatDate(widget.section.lastUpdated)}'),
            const SizedBox(height: 12),
            Text(widget.section.shortDescription, style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
            const Divider(height: 40),

            // AZIONI
            if (PermissionUtils.canCreateExperience(CurrentUser.session))
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _addNewExperience,
                  icon: const Icon(Icons.add),
                  label: const Text('HO DISCESO QUESTO TRATTO'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            
            const SizedBox(height: 30),
            
            // LISTA EXPERIENCE
            Text('Experiences degli utenti', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            if (_localExperiences.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text('Nessuna experience disponibile per questo tratto. Sii il primo a contribuire.'),
              )
            else
              ListView.builder(
                shrinkWrap: true, // Necessario dentro SingleChildScrollView
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _localExperiences.length,
                itemBuilder: (context, index) {
                  final exp = _localExperiences[index];
                  return ExperienceCard(
                    experience: exp,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ExperienceDetailScreen(experience: exp)),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

void _editSection() async {
  final updated = await Navigator.push<RiverSection>(
    context,
    MaterialPageRoute(builder: (_) => EditRiverSectionScreen(section: widget.section)),
  );
if (!mounted) return;

  if (updated != null) {
    setState(() {
      // Aggiorniamo i campi dell'oggetto esistente per riferimento
      // (In un'app reale con state manager useremmo un approccio immutabile)
      widget.section.name = updated.name; // Nota: devi togliere 'final' dai campi nel modello se usi questo approccio, o ricreare l'oggetto
      // Per questa fase, l'approccio più pulito è rimpiazzare i dati
      // o fare il pop e gestire l'aggiornamento nel genitore.
    });
    Navigator.pop(context); // Torniamo alla lista per rinfrescare correttamente
  }
}

}