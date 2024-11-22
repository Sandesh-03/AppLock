import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> authenticate() async {
    final isAvailable = await _auth.canCheckBiometrics;
    if (!isAvailable) return false;

    try {
      return await _auth.authenticate(
        localizedReason: 'Unlock the app',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      return false;
    }
  }
}
