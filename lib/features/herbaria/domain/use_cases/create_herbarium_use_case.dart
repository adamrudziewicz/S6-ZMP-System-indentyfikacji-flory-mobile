import '../entities/herbarium.dart';
import '../repositories/herbarium_repository.dart';

class CreateHerbariumUseCase {
  final HerbariumRepository repository;

  CreateHerbariumUseCase(this.repository);

  Future<Herbarium> call({
    required String name,
    String? description,
    bool isPublic = false,
  }) {
    return repository.createHerbarium(
      name: name,
      description: description,
      isPublic: isPublic,
    );
  }
}
