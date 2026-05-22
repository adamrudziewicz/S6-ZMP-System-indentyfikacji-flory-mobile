import '../entities/friend.dart';
import '../repositories/friend_repository.dart';

class AcceptFriendRequestUseCase {
  final FriendRepository repository;

  AcceptFriendRequestUseCase(this.repository);

  Future<Friend> call(String friendshipId) {
    return repository.acceptFriendRequest(friendshipId);
  }
}
