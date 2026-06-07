import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;
import '../constants/channel_constants.dart';

class SecurityService {
  static const _channel = MethodChannel(ChannelConstants.securityChannel);
  static const _secureScreenKey = 'secure_screen_enabled';

  Future<bool> isSecureScreenEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_secureScreenKey) ?? false;
  }

  Future<void> setSecureScreenEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_secureScreenKey, enabled);
    await _applySecureScreen(enabled);
  }

  Future<void> init() async {
    final enabled = await isSecureScreenEnabled();
    await _applySecureScreen(enabled);
  }

  Future<void> _applySecureScreen(bool enabled) async {
    try {
      await _channel.invokeMethod(ChannelConstants.methodSetSecureScreen, {'enabled': enabled});
    } on PlatformException catch (e) {
      developer.log('Failed to apply secure screen: $e', name: 'SecurityService');
    }
  }
}
