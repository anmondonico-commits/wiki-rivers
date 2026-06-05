import 'package:flutter/material.dart';

class CountrySelectionScreen extends StatefulWidget {
  final List<String> allCountries;
  final List<String> currentSelection;
  final int maxSelection;

  const CountrySelectionScreen({
    super.key,
    required this.allCountries,
    required this.currentSelection,
    this.maxSelection = 4,
  });

  @override
  State<CountrySelectionScreen> createState() => _CountrySelectionScreenState();
}

class _CountrySelectionScreenState extends State<CountrySelectionScreen> {
  late List<String> _tempSelected;

  @override
  void initState() {
    super.initState();
    // Inizializza la lista locale con i valori correnti
    _tempSelected = List.from(widget.currentSelection);
  }

  void _toggleCountry(String country) {
    setState(() {
      if (_tempSelected.contains(country)) {
        _tempSelected.remove(country);
      } else {
        if (_tempSelected.length < widget.maxSelection) {
          _tempSelected.add(country);
        } else {
          // Feedback all'utente se supera il limite
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Puoi selezionare al massimo ${widget.maxSelection} Paesi.'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    });
  }

  void _save() {
    // Ordina alfabeticamente prima di restituire il risultato
    _tempSelected.sort();
    Navigator.pop(context, _tempSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paesi preferiti'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _save,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.teal.withOpacity(0.1),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.teal),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Seleziona fino a ${widget.maxSelection} Paesi da mostrare nella Home.\n'
                    'Attualmente selezionati: ${_tempSelected.length}/${widget.maxSelection}',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.allCountries.length,
              itemBuilder: (context, index) {
                final country = widget.allCountries[index];
                final isSelected = _tempSelected.contains(country);

                return CheckboxListTile(
                  title: Text(country),
                  value: isSelected,
                  activeColor: Colors.teal,
                  onChanged: (_) => _toggleCountry(country),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
                child: const Text('SALVA SELEZIONE'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}