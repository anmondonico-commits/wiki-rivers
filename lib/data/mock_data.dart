import '../models/river.dart';
import '../models/river_section.dart';

class MockData {
  static List<River> getRivers() {
    return [
      // ITALIA
      River(id: 'it_1', name: 'Sesia', country: 'Italia', sections: [
        RiverSection(id: 's1', name: 'Gole del Sesia', difficulty: 4, shortDescription: 'Tratto tecnico.', longDescription: 'Tratto classico molto suggestivo.', lastUpdated: DateTime(2024, 5, 10), updatedBy: 'Admin'),
        RiverSection(id: 's2', name: 'Balmuccia - Varallo', difficulty: 3, shortDescription: 'Tratto classico.', longDescription: 'Il cuore della navigazione sul Sesia.', lastUpdated: DateTime(2024, 6, 12), updatedBy: 'KayakLovers'),
      ]),
      River(id: 'it_2', name: 'Dora Baltea', country: 'Italia', sections: []),
      River(id: 'it_3', name: 'Noce', country: 'Italia', sections: []),
      River(id: 'it_4', name: 'Adda', country: 'Italia', sections: []),
      River(id: 'it_5', name: 'Ticino', country: 'Italia', sections: []),

      // FRANCIA
      River(id: 'fr_1', name: 'Ubaye', country: 'Francia', sections: [
        RiverSection(id: 's3', name: 'Ex-Infras', difficulty: 5, shortDescription: 'Molto impegnativo.', longDescription: 'Solo per esperti, volume e pendenza.', lastUpdated: DateTime(2024, 4, 20), updatedBy: 'FrenchPro'),
      ]),
      River(id: 'fr_2', name: 'Verdon', country: 'Francia', sections: []),
      River(id: 'fr_3', name: 'Durance', country: 'Francia', sections: []),
      River(id: 'fr_4', name: 'Tarn', country: 'Francia', sections: []),
      River(id: 'fr_5', name: 'Guisane', country: 'Francia', sections: []),

      // AUSTRIA
      River(id: 'at_1', name: 'Inn', country: 'Austria', sections: [
        RiverSection(id: 's4', name: 'Imster Schlucht', difficulty: 3, shortDescription: 'Classica austriaca.', longDescription: 'Grandi onde e divertimento assicurato.', lastUpdated: DateTime(2024, 5, 01), updatedBy: 'TirolGuide'),
      ]),
      River(id: 'at_2', name: 'Salzach', country: 'Austria', sections: []),
      River(id: 'at_3', name: 'Enns', country: 'Austria', sections: []),
      River(id: 'at_4', name: 'Ötztaler Ache', country: 'Austria', sections: []),
      River(id: 'at_5', name: 'Gail', country: 'Austria', sections: []),

      // SLOVENIA
      River(id: 'si_1', name: 'Soča / Isonzo', country: 'Slovenia', sections: [
        RiverSection(id: 's5', name: 'Srpenica - Trnovo', difficulty: 3, shortDescription: 'Acqua smeraldo.', longDescription: 'Il tratto più famoso della Slovenia.', lastUpdated: DateTime(2024, 6, 01), updatedBy: 'SloveniaKayak'),
      ]),
      River(id: 'si_2', name: 'Sava', country: 'Slovenia', sections: []),
      River(id: 'si_3', name: 'Savinja', country: 'Slovenia', sections: []),
      River(id: 'si_4', name: 'Krka', country: 'Slovenia', sections: []),
      River(id: 'si_5', name: 'Kolpa', country: 'Slovenia', sections: []),
    ];
  }
}