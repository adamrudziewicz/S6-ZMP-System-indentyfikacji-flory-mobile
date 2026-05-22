import '../entities/plant.dart';
import '../repositories/plant_repository.dart';

class ConfirmPlantUseCase {
  final PlantRepository repository;

  ConfirmPlantUseCase(this.repository);

  Future<Plant> call({
    required String herbariumId,
    required String pendingPhotoId,
    required String decisionType,
    String? existingPlantId,
  }) {
    return repository.confirmPlant(
      herbariumId,
      pendingPhotoId,
      decisionType,
      existingPlantId: existingPlantId,
    );
  }
}
