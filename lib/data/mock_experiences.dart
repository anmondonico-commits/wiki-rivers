import '../models/river_experience.dart';

class MockExperiences {
  static List<RiverExperience> get() {
    return [
      RiverExperience(
        id: 'exp1',
        riverId: 'it_1',
        sectionId: 's1',
        userId: 'u2',
        userDisplayName: 'Luca WhiteWater',
        descentDate: DateTime(2024, 5, 15),
        waterLevel: '120cm all\'idrometro di Campertogno',
        notes: 'Livello perfetto, tutte le linee pulite.',
        hasWarning: false,
        createdAt: DateTime.now(),
      ),
      RiverExperience(
        id: 'exp2',
        riverId: 'it_1',
        sectionId: 's1',
        userId: 'u3',
        userDisplayName: 'Elena River',
        descentDate: DateTime(2024, 6, 02),
        waterLevel: 'Alto',
        notes: 'Navigazione veloce, attenzione ai ritorni.',
        hasWarning: true,
        warningText: 'Presenza di un tronco incastrato subito dopo la rapida del salto.',
        createdAt: DateTime.now(),
      ),
      RiverExperience(
        id: 'si_1',
        sectionId: 's5',
        riverId: 'si_1',
        userId: 'u4',
        userDisplayName: 'SloveniaExplorer',
        descentDate: DateTime(2024, 6, 05),
        waterLevel: 'Medio-Basso',
        notes: 'Sempre magico, acqua un po\' fredda.',
        hasWarning: false,
        createdAt: DateTime.now(),
      ),
    ];
  }
}