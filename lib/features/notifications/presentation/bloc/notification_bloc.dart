import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/error_handler.dart';
import '../../domain/use_cases/get_notifications_use_case.dart';
import '../../domain/use_cases/get_unread_notifications_use_case.dart';
import '../../domain/use_cases/mark_all_notifications_as_read_use_case.dart';
import '../../domain/use_cases/mark_notification_as_read_use_case.dart';
import 'notification_event.dart';
import 'notification_state.dart';
import '../../../../core/notifications/push_notification_service.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUseCase _getNotifications;
  final GetUnreadNotificationsUseCase _getUnreadNotifications;
  final MarkNotificationAsReadUseCase _markAsRead;
  final MarkAllNotificationsAsReadUseCase _markAllAsRead;
  final PushNotificationService _pushNotificationService;

  StreamSubscription? _pushSubscription;

  NotificationBloc({
    required GetNotificationsUseCase getNotifications,
    required GetUnreadNotificationsUseCase getUnreadNotifications,
    required MarkNotificationAsReadUseCase markAsRead,
    required MarkAllNotificationsAsReadUseCase markAllAsRead,
    required PushNotificationService pushNotificationService,
  })  : _getNotifications = getNotifications,
        _getUnreadNotifications = getUnreadNotifications,
        _markAsRead = markAsRead,
        _markAllAsRead = markAllAsRead,
        _pushNotificationService = pushNotificationService,
        super(NotificationInitial()) {
    on<LoadNotifications>(_onLoadNotifications);
    on<LoadUnreadNotifications>(_onLoadUnreadNotifications);
    on<MarkNotificationAsRead>(_onMarkNotificationAsRead);
    on<MarkAllNotificationsAsRead>(_onMarkAllNotificationsAsRead);
    on<PollNotifications>(_onPollNotifications);
    on<StartPollingNotifications>(_onStartPolling);
    on<StopPollingNotifications>(_onStopPolling);
  }

  Future<void> _onLoadNotifications(LoadNotifications event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());
    try {
      final notifications = await _getNotifications();
      emit(NotificationLoaded(notifications));
    } catch (e) {
      emit(NotificationError(ErrorHandler.mapError(e)));
    }
  }

  Future<void> _onPollNotifications(PollNotifications event, Emitter<NotificationState> emit) async {
    try {
      final notifications = await _getNotifications();
      emit(NotificationLoaded(notifications));
    } catch (e) {
    }
  }

  Future<void> _onLoadUnreadNotifications(LoadUnreadNotifications event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());
    try {
      final notifications = await _getUnreadNotifications();
      emit(NotificationLoaded(notifications));
    } catch (e) {
      emit(NotificationError(ErrorHandler.mapError(e)));
    }
  }

  Future<void> _onMarkNotificationAsRead(MarkNotificationAsRead event, Emitter<NotificationState> emit) async {
    try {
      await _markAsRead(event.notificationId);
      add(LoadNotifications());
    } catch (e) {
      emit(NotificationError(ErrorHandler.mapError(e)));
    }
  }

  Future<void> _onMarkAllNotificationsAsRead(MarkAllNotificationsAsRead event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());
    try {
      await _markAllAsRead();
      emit(const NotificationActionSuccess('Wszystkie powiadomienia oznaczone jako odczytane.'));
      add(LoadNotifications());
    } catch (e) {
      emit(NotificationError(ErrorHandler.mapError(e)));
    }
  }

  void _onStartPolling(StartPollingNotifications event, Emitter<NotificationState> emit) {
    _pushSubscription?.cancel();
    _pushSubscription = _pushNotificationService.onMessage.listen((_) {
      add(PollNotifications());
    });
    add(PollNotifications());
  }

  void _onStopPolling(StopPollingNotifications event, Emitter<NotificationState> emit) {
    _pushSubscription?.cancel();
    _pushSubscription = null;
  }

  @override
  Future<void> close() {
    _pushSubscription?.cancel();
    return super.close();
  }
}
