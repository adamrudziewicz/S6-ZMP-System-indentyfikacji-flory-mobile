import '../entities/friend.dart';
import '../repositories/friend_repository.dart';

class GetIncomingFriendRequestsUseCase {
  final FriendRepository repository;

  GetIncomingFriendRequestsUseCase(this.repository);

  Future<List<Friend>> call() {
    return repository.getIncomingFriendRequests();
  }
}
