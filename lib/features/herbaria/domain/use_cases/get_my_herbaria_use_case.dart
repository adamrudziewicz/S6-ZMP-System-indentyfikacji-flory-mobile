import '../entities/herbarium.dart';
import '../repositories/herbarium_repository.dart';

class GetMyHerbariaUseCase {
  final HerbariumRepository repository;

  GetMyHerbariaUseCase(this.repository);

  Future<List<Herbarium>> call() {
    return repository.getMyHerbaria();
  }
}
