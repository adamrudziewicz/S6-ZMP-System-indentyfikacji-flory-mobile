import '../entities/friend.dart';
import '../repositories/friend_repository.dart';

class SendFriendRequestUseCase {
  final FriendRepository repository;

  SendFriendRequestUseCase(this.repository);

  Future<Friend> call(String username) {
    return repository.sendFriendRequest(username);
  }
}
