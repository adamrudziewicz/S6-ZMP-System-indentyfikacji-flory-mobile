import '../../domain/entities/notification.dart';
import '../../domain/repositories/notification_repository.dart';
import '../data_sources/notification_remote_data_source.dart';
import '../models/notification_response.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource _remoteDataSource;

  NotificationRepositoryImpl(this._remoteDataSource);

  Notification _mapDtoToEntity(NotificationResponse dto) {
    return Notification(
      id: dto.id,
      title: dto.title,
      message: dto.message,
      isRead: dto.isRead,
      createdAt: dto.createdAt,
    );
  }

  @override
  Future<List<Notification>> getNotifications() async {
    final response = await _remoteDataSource.getNotifications();
    return response.map(_mapDtoToEntity).toList();
  }

  @override
  Future<List<Notification>> getUnreadNotifications() async {
    final response = await _remoteDataSource.getUnreadNotifications();
    return response.map(_mapDtoToEntity).toList();
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await _remoteDataSource.markAsRead(notificationId);
  }

  @override
  Future<void> markAllAsRead() async {
    await _remoteDataSource.markAllAsRead();
  }
}
