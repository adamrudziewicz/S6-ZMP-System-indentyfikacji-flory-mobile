import '../../domain/entities/friend.dart';
import '../../domain/repositories/friend_repository.dart';
import '../data_sources/friend_remote_data_source.dart';
import '../data_sources/friend_local_data_source.dart';
import '../models/friend_response.dart';
import '../../../../core/network/network_info.dart';

class FriendRepositoryImpl implements FriendRepository {
  final FriendRemoteDataSource _remoteDataSource;
  final FriendLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  FriendRepositoryImpl(this._remoteDataSource, this._localDataSource, this._networkInfo);

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
    if (await _networkInfo.isConnected) {
      try {
        final list = await _remoteDataSource.getFriends();
        await _localDataSource.cacheFriends(list);
        return list.map(_mapDtoToEntity).toList();
      } catch (e) {
        final cached = await _localDataSource.getCachedFriends();
        return cached.map(_mapDtoToEntity).toList();
      }
    } else {
      final cached = await _localDataSource.getCachedFriends();
      return cached.map(_mapDtoToEntity).toList();
    }
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
    if (await _networkInfo.isConnected) {
      try {
        final list = await _remoteDataSource.getIncomingFriendRequests();
        await _localDataSource.cacheIncomingRequests(list);
        return list.map(_mapDtoToEntity).toList();
      } catch (e) {
        final cached = await _localDataSource.getCachedIncomingRequests();
        return cached.map(_mapDtoToEntity).toList();
      }
    } else {
      final cached = await _localDataSource.getCachedIncomingRequests();
      return cached.map(_mapDtoToEntity).toList();
    }
  }

  @override
  Future<List<Friend>> getSentFriendRequests() async {
    if (await _networkInfo.isConnected) {
      try {
        final list = await _remoteDataSource.getSentFriendRequests();
        await _localDataSource.cacheSentRequests(list);
        return list.map(_mapDtoToEntity).toList();
      } catch (e) {
        final cached = await _localDataSource.getCachedSentRequests();
        return cached.map(_mapDtoToEntity).toList();
      }
    } else {
      final cached = await _localDataSource.getCachedSentRequests();
      return cached.map(_mapDtoToEntity).toList();
    }
  }

  @override
  Future<void> deleteFriendship(String friendshipId) async {
    await _remoteDataSource.deleteFriendship(friendshipId);
  }
}
