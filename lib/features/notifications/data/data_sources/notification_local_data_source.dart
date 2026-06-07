import 'dart:convert';
import 'package:hive/hive.dart';
import '../models/notification_response.dart';

abstract class NotificationLocalDataSource {
  Future<List<NotificationResponse>> getCachedNotifications();
  Future<void> cacheNotifications(List<NotificationResponse> notifications);
}

const String _notificationsBox = 'notifications_cache';

class NotificationLocalDataSourceImpl implements NotificationLocalDataSource {
  Future<Box> get _cacheBox async => await Hive.openBox(_notificationsBox);

  @override
  Future<List<NotificationResponse>> getCachedNotifications() async {
    final box = await _cacheBox;
    final String? jsonString = box.get('all_notifications');
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((e) => NotificationResponse.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Future<void> cacheNotifications(List<NotificationResponse> notifications) async {
    final box = await _cacheBox;
    final jsonList = notifications.map((e) => e.toJson()).toList();
    await box.put('all_notifications', jsonEncode(jsonList));
  }
}
