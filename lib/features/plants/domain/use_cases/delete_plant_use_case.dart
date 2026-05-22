import '../repositories/plant_repository.dart';

class DeletePlantUseCase {
  final PlantRepository repository;

  DeletePlantUseCase(this.repository);

  Future<void> call({required String herbariumId, required String plantId}) {
    return repository.deletePlant(herbariumId, plantId);
  }
}
