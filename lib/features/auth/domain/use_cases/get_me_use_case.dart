import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class GetMeUseCase {
  final AuthRepository repository;

  GetMeUseCase(this.repository);

  Future<User> call() {
    return repository.me();
  }
}
