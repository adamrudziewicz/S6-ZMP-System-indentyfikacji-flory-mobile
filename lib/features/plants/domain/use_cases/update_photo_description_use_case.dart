import '../entities/plant.dart';
import '../repositories/plant_repository.dart';

class UpdatePhotoDescriptionUseCase {
  final PlantRepository repository;

  UpdatePhotoDescriptionUseCase(this.repository);

  Future<Plant> call(String herbariumId, String plantId, String photoId, String description) {
    return repository.updatePhotoDescription(herbariumId, plantId, photoId, description);
  }
}
