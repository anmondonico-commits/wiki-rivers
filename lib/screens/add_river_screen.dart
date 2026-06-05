import 'package:flutter/material.dart';
import '../models/river.dart';
import '../data/available_countries.dart';

class AddRiverScreen extends StatefulWidget {
  const AddRiverScreen({super.key});

  @override
  State<AddRiverScreen> createState() => _AddRiverScreenState();
}

class _AddRiverScreenState extends State<AddRiverScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  String? _selectedCountry;

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate() && _selectedCountry != null) {
      final newRiver = River(
        id: 'river_${DateTime.now().millisecondsSinceEpoch}',
        name: _nameController.text,
        country: _selectedCountry!,
        description: _descController.text,
        sections: [],
      );
      Navigator.pop(context, newRiver);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuovo Fiume')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome Fiume *', border: OutlineInputBorder()),
              validator: (v) => v == null || v.isEmpty ? 'Obbligatorio' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedCountry,
              decoration: const InputDecoration(labelText: 'Paese *', border: OutlineInputBorder()),
              items: availableCountries.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (val) => setState(() => _selectedCountry = val),
              validator: (v) => v == null ? 'Seleziona un Paese' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Descrizione sommaria *', border: OutlineInputBorder()),
              validator: (v) => v == null || v.isEmpty ? 'Obbligatorio' : null,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white, padding: const EdgeInsets.all(16)),
              child: const Text('CREA FIUME'),
            ),
          ],
        ),
      ),
    );
  }
}