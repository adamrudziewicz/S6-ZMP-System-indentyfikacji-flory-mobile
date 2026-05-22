import '../repositories/friend_repository.dart';

class DeleteFriendshipUseCase {
  final FriendRepository repository;

  DeleteFriendshipUseCase(this.repository);

  Future<void> call(String friendshipId) {
    return repository.deleteFriendship(friendshipId);
  }
}
