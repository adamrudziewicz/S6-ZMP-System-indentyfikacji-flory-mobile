import 'plant_photo.dart';

class Plant {
  final String id;
  final String herbariumId;
  final String? name;
  final bool recognized;
  final String? detectedSpecies;
  final String? speciesId;
  final String? family;
  final String? genus;
  final String? commonNames;
  final double? confidence;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<PlantPhoto> photos;
  final List<Plant> recommendedPlants;

  Plant({
    required this.id,
    required this.herbariumId,
    this.name,
    required this.recognized,
    this.detectedSpecies,
    this.speciesId,
    this.family,
    this.genus,
    this.commonNames,
    this.confidence,
    this.createdAt,
    this.updatedAt,
    this.photos = const [],
    this.recommendedPlants = const [],
  });
}
