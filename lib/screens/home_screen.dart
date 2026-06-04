import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/river.dart';
import '../widgets/river_card.dart';
import 'river_sections_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _countries = ['Italia', 'Francia', 'Austria', 'Slovenia'];
  String _selectedCountry = 'Italia';

  @override
  Widget build(BuildContext context) {
    final filteredRivers = MockData.getRivers()
        .where((r) => r.country == _selectedCountry)
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));

    return Scaffold(
      appBar: AppBar(title: const Text('Wiki-Rivers')),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: Row(
              children: _countries.map((country) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(country),
                    selected: _selectedCountry == country,
                    onSelected: (selected) {
                      if (selected) setState(() => _selectedCountry = country);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: filteredRivers.isEmpty
                ? const Center(child: Text('Nessun fiume disponibile.'))
                : ListView.builder(
                    itemCount: filteredRivers.length,
                    itemBuilder: (context, index) {
                      final river = filteredRivers[index];
                      return RiverCard(
                        river: river,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => RiverSectionsScreen(river: river)),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}