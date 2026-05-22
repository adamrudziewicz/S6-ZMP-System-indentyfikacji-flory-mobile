import '../../../../core/api/api_service.dart';
import '../models/notification_response.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationResponse>> getNotifications();
  Future<List<NotificationResponse>> getUnreadNotifications();
  Future<void> markAsRead(String notificationId);
  Future<void> markAllAsRead();
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final ApiService _apiService;

  NotificationRemoteDataSourceImpl(this._apiService);

  @override
  Future<List<NotificationResponse>> getNotifications() async {
    final response = await _apiService.client.get('/notifications');
    return (response.data as List).map((e) => NotificationResponse.fromJson(e)).toList();
  }

  @override
  Future<List<NotificationResponse>> getUnreadNotifications() async {
    final response = await _apiService.client.get('/notifications/unread');
    return (response.data as List).map((e) => NotificationResponse.fromJson(e)).toList();
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await _apiService.client.patch('/notifications/$notificationId/read');
  }

  @override
  Future<void> markAllAsRead() async {
    await _apiService.client.patch('/notifications/read-all');
  }
}
