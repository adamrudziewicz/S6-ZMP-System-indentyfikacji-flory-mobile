import 'package:dio/dio.dart';
import '../../../../core/api/api_service.dart';
import '../models/friend_response.dart';
import '../models/friend_request_body.dart';

abstract class FriendRemoteDataSource {
  Future<List<FriendResponse>> getFriends();
  Future<FriendResponse> sendFriendRequest(String username);
  Future<FriendResponse> acceptFriendRequest(String friendshipId);
  Future<List<FriendResponse>> getIncomingFriendRequests();
  Future<List<FriendResponse>> getSentFriendRequests();
  Future<void> deleteFriendship(String friendshipId);
}

class FriendRemoteDataSourceImpl implements FriendRemoteDataSource {
  final ApiService _apiService;

  FriendRemoteDataSourceImpl(this._apiService);

  @override
  Future<List<FriendResponse>> getFriends() async {
    final response = await _apiService.client.get('/friends');
    return (response.data as List)
        .map((e) => FriendResponse.fromJson(e))
        .toList();
  }

  @override
  Future<FriendResponse> sendFriendRequest(String username) async {
    final response = await _apiService.client.post(
      '/friends/request',
      data: FriendRequestBody(username: username).toJson(),
    );
    return FriendResponse.fromJson(response.data);
  }

  @override
  Future<FriendResponse> acceptFriendRequest(String friendshipId) async {
    final response = await _apiService.client.post(
      '/friends/$friendshipId/accept',
    );
    return FriendResponse.fromJson(response.data);
  }

  @override
  Future<List<FriendResponse>> getIncomingFriendRequests() async {
    final response = await _apiService.client.get('/friends/requests');
    return (response.data as List)
        .map((e) => FriendResponse.fromJson(e))
        .toList();
  }

  @override
  Future<List<FriendResponse>> getSentFriendRequests() async {
    final response = await _apiService.client.get('/friends/requests/sent');
    return (response.data as List)
        .map((e) => FriendResponse.fromJson(e))
        .toList();
  }

  @override
  Future<void> deleteFriendship(String friendshipId) async {
    await _apiService.client.delete('/friends/$friendshipId');
  }
}
