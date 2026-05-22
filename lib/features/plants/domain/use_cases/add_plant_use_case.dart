import 'dart:io';
import '../entities/plant.dart';
import '../repositories/plant_repository.dart';

class AddPlantUseCase {
  final PlantRepository repository;

  AddPlantUseCase(this.repository);

  Future<Plant> call({
    required String herbariumId,
    required File photoFile,
    String? photoDescription,
  }) {
    return repository.addPlant(herbariumId, photoFile, photoDescription: photoDescription);
  }
}
