import 'package:flutter/material.dart';
import '../models/river_experience.dart';
import '../data/current_user.dart';

class AddExperienceScreen extends StatefulWidget {
  final String riverId;
  final String sectionId;

  const AddExperienceScreen({
    super.key,
    required this.riverId,
    required this.sectionId,
  });

  @override
  State<AddExperienceScreen> createState() => _AddExperienceScreenState();
}

class _AddExperienceScreenState extends State<AddExperienceScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  final _waterController = TextEditingController();
  final _notesController = TextEditingController();
  final _warningController = TextEditingController();
  bool _hasWarning = false;

  @override
  void dispose() {
    _waterController.dispose();
    _notesController.dispose();
    _warningController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final newExp = RiverExperience(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        riverId: widget.riverId,
        sectionId: widget.sectionId,
        userId: CurrentUser.session.id,
        userDisplayName: CurrentUser.session.displayName,
        descentDate: _selectedDate,
        waterLevel: _waterController.text,
        notes: _notesController.text,
        hasWarning: _hasWarning,
        warningText: _hasWarning ? _warningController.text : null,
        createdAt: DateTime.now(),
      );
      Navigator.pop(context, newExp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registra Discesa')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            ListTile(
              title: const Text('Data della discesa'),
              subtitle: Text('${_selectedDate.toLocal()}'.split(' ')[0]),
              trailing: const Icon(Icons.calendar_today),
              onTap: _pickDate,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _waterController,
              decoration: const InputDecoration(labelText: 'Livello dell\'acqua *', border: OutlineInputBorder()),
              validator: (v) => v == null || v.isEmpty ? 'Obbligatorio' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Note sulla discesa *', border: OutlineInputBorder()),
              validator: (v) => v == null || v.isEmpty ? 'Obbligatorio' : null,
            ),
            SwitchListTile(
              title: const Text('Segnala pericolo o difficoltà inattesa'),
              value: _hasWarning,
              onChanged: (v) => setState(() => _hasWarning = v),
            ),
            if (_hasWarning)
              TextFormField(
                controller: _warningController,
                decoration: const InputDecoration(labelText: 'Descrizione pericolo *', border: OutlineInputBorder()),
                validator: (v) => _hasWarning && (v == null || v.isEmpty) ? 'Obbligatorio se c\'è un pericolo' : null,
              ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
              child: const Text('SALVA EXPERIENCE'),
            ),
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annulla')),
          ],
        ),
      ),
    );
  }
}