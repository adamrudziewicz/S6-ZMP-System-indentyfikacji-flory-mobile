import '../entities/plant.dart';
import '../repositories/plant_repository.dart';

class UpdatePlantNameUseCase {
  final PlantRepository repository;

  UpdatePlantNameUseCase(this.repository);

  Future<Plant> call(String herbariumId, String plantId, String name) {
    return repository.updatePlantName(herbariumId, plantId, name);
  }
}
