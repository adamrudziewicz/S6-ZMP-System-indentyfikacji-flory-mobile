import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class BiometryService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> canCheckBiometrics() async {
    try {
      final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      final bool canAuthenticate = await _auth.isDeviceSupported();
      return canAuthenticateWithBiometrics || canAuthenticate;
    } on PlatformException catch (_) {
      return false;
    }
  }

  Future<bool> authenticate() async {
    try {
      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: 'Zeskanuj odcisk palca lub twarz, aby odblokować aplikację',
      );
      return didAuthenticate;
    } on PlatformException catch (_) {
      return false;
    }
  }
}
