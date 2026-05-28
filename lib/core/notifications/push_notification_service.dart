import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer' as developer;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  developer.log('Handling a background message: ${message.messageId}', name: 'PushNotificationService');
}

class PushNotificationService {
  final FirebaseMessaging _messaging;

  final _messageController = StreamController<RemoteMessage>.broadcast();
  Stream<RemoteMessage> get onMessage => _messageController.stream;

  PushNotificationService() : _messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    try {
      
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      
      final settings = await _messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      developer.log('User granted permission: ${settings.authorizationStatus}', name: 'PushNotificationService');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        developer.log('Got a message whilst in the foreground!', name: 'PushNotificationService');
        developer.log('Message data: ${message.data}', name: 'PushNotificationService');

        if (message.notification != null) {
          developer.log('Message also contained a notification: ${message.notification}', name: 'PushNotificationService');
        }
        
        _messageController.add(message);
      });

    } catch (e) {
      developer.log('Failed to initialize push notifications: $e', name: 'PushNotificationService', error: e);
    }
  }

  Future<String?> getToken() async {
    try {
      return await _messaging.getToken();
    } catch (e) {
      developer.log('Error getting FCM token', name: 'PushNotificationService', error: e);
      return null;
    }
  }

  Stream<String> get onTokenRefresh => _messaging.onTokenRefresh;
}
