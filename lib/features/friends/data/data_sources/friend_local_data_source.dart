import 'dart:convert';
import 'package:hive/hive.dart';
import '../models/friend_response.dart';

abstract class FriendLocalDataSource {
  Future<List<FriendResponse>> getCachedFriends();
  Future<void> cacheFriends(List<FriendResponse> friends);
  
  Future<List<FriendResponse>> getCachedIncomingRequests();
  Future<void> cacheIncomingRequests(List<FriendResponse> requests);
  
  Future<List<FriendResponse>> getCachedSentRequests();
  Future<void> cacheSentRequests(List<FriendResponse> requests);
}

const String _friendsBox = 'friends_cache';

class FriendLocalDataSourceImpl implements FriendLocalDataSource {
  Future<Box> get _cacheBox async => await Hive.openBox(_friendsBox);

  @override
  Future<List<FriendResponse>> getCachedFriends() async {
    return _getListFromBox('all_friends');
  }

  @override
  Future<void> cacheFriends(List<FriendResponse> friends) async {
    await _saveListToBox('all_friends', friends);
  }

  @override
  Future<List<FriendResponse>> getCachedIncomingRequests() async {
    return _getListFromBox('incoming_requests');
  }

  @override
  Future<void> cacheIncomingRequests(List<FriendResponse> requests) async {
    await _saveListToBox('incoming_requests', requests);
  }

  @override
  Future<List<FriendResponse>> getCachedSentRequests() async {
    return _getListFromBox('sent_requests');
  }

  @override
  Future<void> cacheSentRequests(List<FriendResponse> requests) async {
    await _saveListToBox('sent_requests', requests);
  }

  Future<List<FriendResponse>> _getListFromBox(String key) async {
    final box = await _cacheBox;
    final String? jsonString = box.get(key);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((e) => FriendResponse.fromJson(e)).toList();
    }
    return [];
  }

  Future<void> _saveListToBox(String key, List<FriendResponse> list) async {
    final box = await _cacheBox;
    final jsonList = list.map((e) => e.toJson()).toList();
    await box.put(key, jsonEncode(jsonList));
  }
}
