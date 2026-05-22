import '../entities/notification.dart';
import '../repositories/notification_repository.dart';

class GetUnreadNotificationsUseCase {
  final NotificationRepository repository;

  GetUnreadNotificationsUseCase(this.repository);

  Future<List<Notification>> call() {
    return repository.getUnreadNotifications();
  }
}
