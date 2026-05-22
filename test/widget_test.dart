import 'package:flutter_test/flutter_test.dart';
import 'package:system_identyfikacji_flory/features/plants/data/models/plant_response.dart';

void main() {
  group('Plant Model Serialization Tests', () {
    test('should correctly parse PlantResponse from JSON with new taxonomic fields', () {
      final json = {
        'id': 'a1a1a1a1-a1a1-a1a1-a1a1-a1a1a1a1a1a1',
        'herbariumId': 'b2b2b2b2-b2b2-b2b2-b2b2-b2b2b2b2b2b2',
        'name': 'Róża',
        'detectedSpecies': 'Rosa canina',
        'speciesId': 'species_123',
        'family': 'Rosaceae',
        'genus': 'Rosa',
        'commonNames': 'Szypszyna, Dzika róża',
        'createdAt': '2026-05-20T20:00:00Z',
        'updatedAt': '2026-05-20T20:00:00Z',
        'photos': [
          {
            'id': 'p1p1p1p1-p1p1-p1p1-p1p1-p1p1p1p1p1p1',
            'plantId': 'a1a1a1a1-a1a1-a1a1-a1a1-a1a1a1a1a1a1',
            'url': 'https://example.com/photo.jpg',
            'description': 'Dzika róża z bliska',
            'confidence': 0.95,
            'createdAt': '2026-05-20T20:00:00Z'
          }
        ]
      };

      final response = PlantResponse.fromJson(json);

      expect(response.id, 'a1a1a1a1-a1a1-a1a1-a1a1-a1a1a1a1a1a1');
      expect(response.name, 'Róża');
      expect(response.detectedSpecies, 'Rosa canina');
      expect(response.speciesId, 'species_123');
      expect(response.family, 'Rosaceae');
      expect(response.genus, 'Rosa');
      expect(response.commonNames, 'Szypszyna, Dzika róża');
      expect(response.photos.first.confidence, 0.95);
    });
  });
}
