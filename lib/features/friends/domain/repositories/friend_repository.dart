import '../../domain/entities/friend.dart';

abstract class FriendRepository {
  Future<List<Friend>> getFriends();
  Future<Friend> sendFriendRequest(String username);
  Future<Friend> acceptFriendRequest(String friendshipId);
  Future<List<Friend>> getIncomingFriendRequests();
  Future<List<Friend>> getSentFriendRequests();
  Future<void> deleteFriendship(String friendshipId);
}
