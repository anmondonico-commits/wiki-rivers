import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../data/available_countries.dart';
import '../data/default_selected_countries.dart';
import '../data/current_user.dart';
import '../models/river.dart';
import '../widgets/river_card.dart';
import '../utils/permission_utils.dart';
import 'river_sections_screen.dart';
import 'country_selection_screen.dart';
import 'add_river_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<River> _allRivers;
  List<String> _preferredCountries = List.from(defaultSelectedCountries);
  String? _activeCountry;

  @override
  void initState() {
    super.initState();
    _allRivers = MockData.getRivers(); // Inizializzazione dai mock
    if (_preferredCountries.isNotEmpty) {
      _activeCountry = _preferredCountries.first;
    }
  }

  void _addRiver() async {
    final newRiver = await Navigator.push<River>(
      context,
      MaterialPageRoute(builder: (_) => const AddRiverScreen()),
    );
    if (newRiver != null) {
      setState(() {
        _allRivers.add(newRiver);
        _allRivers.sort((a, b) => a.name.compareTo(b.name));
        // Opzionale: attiva il paese del nuovo fiume per vederlo subito
        _activeCountry = newRiver.country;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Il filtraggio avviene sempre sulla lista locale mutabile _allRivers
    final filteredRivers = _activeCountry == null
        ? <River>[]
        : _allRivers.where((r) => r.country == _activeCountry).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wiki-Rivers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune), 
            onPressed: () async {
              final result = await Navigator.push<List<String>>(
                context, 
                MaterialPageRoute(
                  builder: (_) => CountrySelectionScreen(
                    allCountries: availableCountries, 
                    currentSelection: _preferredCountries
                  )
                )
              );
              if (result != null) {
                setState(() {
                  _preferredCountries = result;
                  if (_preferredCountries.isEmpty) {
                    _activeCountry = null;
                  } else if (_activeCountry == null || !_preferredCountries.contains(_activeCountry)) {
                    _activeCountry = _preferredCountries.first;
                  }
                });
              }
            }
          ),
        ],
      ),
      body: Column(
        children: [
          // -----------------------------------------------------------------
          // IMPLEMENTAZIONE DINAMICA DEI PULSANTI PAESE (ChoiceChips)
          // -----------------------------------------------------------------
          if (_preferredCountries.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: _preferredCountries.map((country) {
                    final isSelected = _activeCountry == country;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(country),
                        selected: isSelected,
                        selectedColor: Colors.teal,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        onSelected: (selected) {
                          if (selected) {
                            setState(() => _activeCountry = country);
                          }
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          
          // -----------------------------------------------------------------
          // LISTA FIUMI
          // -----------------------------------------------------------------
          Expanded(
            child: _preferredCountries.isEmpty
                ? const Center(child: Text('Seleziona almeno un Paese dai filtri.'))
                : filteredRivers.isEmpty
                    ? Center(child: Text('Nessun fiume trovato per $_activeCountry.'))
                    : ListView.builder(
                        itemCount: filteredRivers.length,
                        itemBuilder: (context, index) => RiverCard(
                          river: filteredRivers[index],
                          onTap: () => Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (_) => RiverSectionsScreen(river: filteredRivers[index])
                            )
                          ).then((_) => setState(() {})), // Mantiene la sincronizzazione se torni da modifiche
                        ),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: PermissionUtils.canCreateRiver(CurrentUser.session) ? _addRiver : null,
        backgroundColor: PermissionUtils.canCreateRiver(CurrentUser.session) ? Colors.teal : Colors.grey,
        icon: const Icon(Icons.add),
        label: const Text('Nuovo Fiume'),
      ),
    );
  }
}