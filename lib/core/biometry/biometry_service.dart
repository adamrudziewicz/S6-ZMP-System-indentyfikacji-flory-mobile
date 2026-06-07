import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class BiometryService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> canCheckBiometrics() async {
    try {
      final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      final bool canAuthenticate = await _auth.isDeviceSupported();
      return canAuthenticateWithBiometrics || canAuthenticate;
    } catch (e) {
      developer.log('canCheckBiometrics failed: $e', name: 'BiometryService');
      return false;
    }
  }

  Future<bool> authenticate() async {
    try {
      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: 'Zeskanuj odcisk palca lub twarz, aby odblokować aplikację',
      );
      return didAuthenticate;
    } catch (e) {
      developer.log('authenticate failed: $e', name: 'BiometryService');
      return false;
    }
  }

  Future<bool> isBiometryEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('biometry_enabled') ?? false;
  }

  Future<void> setBiometryEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('biometry_enabled', enabled);
  }
}
