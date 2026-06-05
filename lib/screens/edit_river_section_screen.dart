import 'package:flutter/material.dart';
import '../models/river_section.dart';
import '../data/current_user.dart';

class EditRiverSectionScreen extends StatefulWidget {
  final RiverSection? section; // Se null, siamo in modalità creazione

  const EditRiverSectionScreen({super.key, this.section});

  @override
  State<EditRiverSectionScreen> createState() => _EditRiverSectionScreenState();
}

class _EditRiverSectionScreenState extends State<EditRiverSectionScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  //late TextEditingController _waterController;
  late TextEditingController _descController;
  int _difficulty = 3;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.section?.name ?? '');
    _descController = TextEditingController(text: widget.section?.shortDescription ?? '');
    _difficulty = widget.section?.difficulty ?? 3;
  }

  @override
  void dispose() {
    _nameController.dispose();
    //_waterController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final updatedSection = RiverSection(
        id: widget.section?.id ?? 'sec_${DateTime.now().millisecondsSinceEpoch}',
        name: _nameController.text,
        difficulty: _difficulty,
        shortDescription: _descController.text,
        longDescription: widget.section?.longDescription ?? '',
        lastUpdated: DateTime.now(),
        updatedBy: CurrentUser.session.displayName,
      );
      Navigator.pop(context, updatedSection);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.section != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Modifica Tratto' : 'Nuovo Tratto')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome Tratto *', border: OutlineInputBorder()),
              validator: (v) => v == null || v.isEmpty ? 'Obbligatorio' : null,
            ),
            const SizedBox(height: 16),
            const Text('Difficoltà WW (1-6)'),
            Slider(
              value: _difficulty.toDouble(),
              min: 1, max: 6, divisions: 5,
              label: 'WW $_difficulty',
              onChanged: (v) => setState(() => _difficulty = v.toInt()),
            ),
            const SizedBox(height: 16),
       //     TextFormField(
       //       controller: _waterController,
       //       decoration: const InputDecoration(labelText: 'Livello Acqua *', border: OutlineInputBorder()),
       //       validator: (v) => v == null || v.isEmpty ? 'Obbligatorio' : null,
       //     ),
       //     const SizedBox(height: 16),
            TextFormField(
              controller: _descController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Breve descrizione *', border: OutlineInputBorder()),
              validator: (v) => v == null || v.isEmpty ? 'Obbligatorio' : null,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white, padding: const EdgeInsets.all(16)),
              child: Text(isEdit ? 'SALVA MODIFICHE' : 'CREA TRATTO'),
            ),
          ],
        ),
      ),
    );
  }
}