import '../entities/plant.dart';
import '../repositories/plant_repository.dart';

class GetPlantsUseCase {
  final PlantRepository _repository;

  GetPlantsUseCase(this._repository);

  Future<List<Plant>> call(String herbariumId) async {
    return await _repository.getPlants(herbariumId);
  }
}
