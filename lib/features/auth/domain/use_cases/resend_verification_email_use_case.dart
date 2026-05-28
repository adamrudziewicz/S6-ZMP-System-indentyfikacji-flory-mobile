import '../repositories/auth_repository.dart';

class ResendVerificationEmailUseCase {
  final AuthRepository _repository;

  ResendVerificationEmailUseCase(this._repository);

  Future<void> call(String email) async {
    return await _repository.resendVerificationEmail(email);
  }
}
