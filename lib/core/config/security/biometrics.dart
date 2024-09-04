// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:io';


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

class Biometrics {
  Biometrics(this.localAuthentication);
  final LocalAuthentication localAuthentication;
 // final LocalStorage keyValueStore;

  Future<BiometricType?> getAvailableBiometrics() async {
    final availableBiometrics =
        await localAuthentication.getAvailableBiometrics();
    if (availableBiometrics.isEmpty) return null;
    if (Platform.isIOS) {
      if (availableBiometrics.contains(BiometricType.face)) {
        return BiometricType.face;
      } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
        // Touch ID.
        return BiometricType.fingerprint;
      } else {
        return availableBiometrics.first;
      }
    } else {
      // Android FingerPrint
      return BiometricType.fingerprint;
    }
  }

  Future<bool> canDoBiometrics() async {
    final canDoBiometrics = await localAuthentication.canCheckBiometrics;
    final isDeviceSupported = await localAuthentication.isDeviceSupported();
    return canDoBiometrics && isDeviceSupported;
  }

  Future<bool> performAuth(String v) async {
    try {
      final didAuthenticate = await localAuthentication.authenticate(
        localizedReason: v,
      );
      return didAuthenticate;
    } catch (e) {
      return false;
    }
  }

  Future<bool> stopAuthentication() async {
    return localAuthentication.stopAuthentication();
  }

  // bool get enabledBiometrics =>
  //     keyValueStore.get(HiveKeys.enabledBiometrics) as bool? ?? false;

  // Future<void> setBiometric(bool val) async => keyValueStore.put(
  //       HiveKeys.enabledBiometrics,
  //       val,
  //     );
}

final biometricsProvider = Provider<Biometrics>(
  (ref) => Biometrics(
    LocalAuthentication(),
    //ref.read(localStorageProvider),
  ),
);
