import '../entities/notification.dart';

abstract class NotificationRepository {
  Future<List<Notification>> getNotifications();
  Future<List<Notification>> getUnreadNotifications();
  Future<void> markAsRead(String notificationId);
  Future<void> markAllAsRead();
}
