import '../../domain/entities/friend.dart';
import '../../domain/repositories/friend_repository.dart';
import '../data_sources/friend_remote_data_source.dart';
import '../models/friend_response.dart';

class FriendRepositoryImpl implements FriendRepository {
  final FriendRemoteDataSource _remoteDataSource;

  FriendRepositoryImpl(this._remoteDataSource);

  Friend _mapDtoToEntity(FriendResponse dto) {
    return Friend(
      friendshipId: dto.friendshipId,
      userId: dto.userId,
      username: dto.username,
      status: dto.status,
      direction: dto.direction,
      createdAt: dto.createdAt,
    );
  }

  @override
  Future<List<Friend>> getFriends() async {
    final list = await _remoteDataSource.getFriends();
    return list.map(_mapDtoToEntity).toList();
  }

  @override
  Future<Friend> sendFriendRequest(String username) async {
    final response = await _remoteDataSource.sendFriendRequest(username);
    return _mapDtoToEntity(response);
  }

  @override
  Future<Friend> acceptFriendRequest(String friendshipId) async {
    final response = await _remoteDataSource.acceptFriendRequest(friendshipId);
    return _mapDtoToEntity(response);
  }

  @override
  Future<List<Friend>> getIncomingFriendRequests() async {
    final list = await _remoteDataSource.getIncomingFriendRequests();
    return list.map(_mapDtoToEntity).toList();
  }

  @override
  Future<List<Friend>> getSentFriendRequests() async {
    final list = await _remoteDataSource.getSentFriendRequests();
    return list.map(_mapDtoToEntity).toList();
  }

  @override
  Future<void> deleteFriendship(String friendshipId) async {
    await _remoteDataSource.deleteFriendship(friendshipId);
  }
}
