import '../../domain/entities/notification.dart';
import '../../domain/repositories/notification_repository.dart';
import '../data_sources/notification_remote_data_source.dart';
import '../data_sources/notification_local_data_source.dart';
import '../models/notification_response.dart';
import '../../../../core/network/network_info.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource _remoteDataSource;
  final NotificationLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  NotificationRepositoryImpl(this._remoteDataSource, this._localDataSource, this._networkInfo);

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
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getNotifications();
        await _localDataSource.cacheNotifications(response);
        return response.map(_mapDtoToEntity).toList();
      } catch (e) {
        final cached = await _localDataSource.getCachedNotifications();
        return cached.map(_mapDtoToEntity).toList();
      }
    } else {
      final cached = await _localDataSource.getCachedNotifications();
      return cached.map(_mapDtoToEntity).toList();
    }
  }

  @override
  Future<List<Notification>> getUnreadNotifications() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getUnreadNotifications();
        return response.map(_mapDtoToEntity).toList();
      } catch (e) {
        final cached = await _localDataSource.getCachedNotifications();
        return cached.where((n) => !n.isRead).map(_mapDtoToEntity).toList();
      }
    } else {
      final cached = await _localDataSource.getCachedNotifications();
      return cached.where((n) => !n.isRead).map(_mapDtoToEntity).toList();
    }
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await _remoteDataSource.markAsRead(notificationId);
    final cached = await _localDataSource.getCachedNotifications();
    final updated = cached.map((n) => n.id == notificationId ? n.copyWith(isRead: true) : n).toList();
    await _localDataSource.cacheNotifications(updated);
  }

  @override
  Future<void> markAllAsRead() async {
    await _remoteDataSource.markAllAsRead();
    final cached = await _localDataSource.getCachedNotifications();
    final updated = cached.map((n) => n.copyWith(isRead: true)).toList();
    await _localDataSource.cacheNotifications(updated);
  }
}
