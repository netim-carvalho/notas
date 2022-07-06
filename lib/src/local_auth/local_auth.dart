import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth {
  final LocalAuthentication localAuthentication = LocalAuthentication();

  Future<bool> isDeviceSupported() async {
    late bool isDeviceSupported;
    try {
      isDeviceSupported = await localAuthentication.isDeviceSupported();
    } on PlatformException catch (e) {
      isDeviceSupported = false;
      SnackBarAction(
        onPressed: () {},
        label: e.message.toString(),
      );
    }
    return isDeviceSupported;
  }

  Future<bool> checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
    }
    return canCheckBiometrics;
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
    }

    return availableBiometrics;
  }

  Future<bool> authenticate() async {
    bool authenticated = false;
    final bool check = await checkBiometrics().then((value) => value);
    final bool supported = await checkBiometrics().then((value) => value);

    if (!check || !supported ) {
      print("Check $check");
      print("Supported $supported");
      return authenticated;
    }

    try {
      authenticated = await localAuthentication.authenticate(
        localizedReason: 'Desbloquei a nota protegida para ter acesso!',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (e) {}
    return authenticated;
  }

  Future<bool> authenticateWithBiometrics() async {
    final bool check = await checkBiometrics().then((value) => value);

    if (!check) {
      return false;
    }

    bool authenticated = false;
    try {
      authenticated = await localAuthentication.authenticate(
        localizedReason: 'Utilize a biometria para acessar sua nota protegida!',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {}
    return authenticated;
  }
}
