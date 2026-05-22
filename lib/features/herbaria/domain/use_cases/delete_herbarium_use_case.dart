import '../repositories/herbarium_repository.dart';

class DeleteHerbariumUseCase {
  final HerbariumRepository repository;

  DeleteHerbariumUseCase(this.repository);

  Future<void> call(String herbariumId) {
    return repository.deleteHerbarium(herbariumId);
  }
}
