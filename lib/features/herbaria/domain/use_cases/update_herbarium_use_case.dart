import '../entities/herbarium.dart';
import '../repositories/herbarium_repository.dart';

class UpdateHerbariumUseCase {
  final HerbariumRepository _repository;

  UpdateHerbariumUseCase(this._repository);

  Future<Herbarium> call({
    required String id,
    required String name,
    String? description,
    required bool isPublic,
  }) {
    return _repository.updateHerbarium(
      id,
      name: name,
      description: description,
      isPublic: isPublic,
    );
  }
}
