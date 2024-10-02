import 'dart:async';


import 'package:flutter_riverpod/flutter_riverpod.dart';

// class LocalStorageImpl implements LocalStorage {
//   LocalStorageImpl(this.box);
//   final Box box;
//   @override
//   Future<void> put(dynamic key, dynamic value) async {
//     return box.put(key, value);
//   }

//   @override
//   dynamic get<T>(String key) {
//     return box.get(key);
//   }

//   @override
//   dynamic getAt(int key) {
//     return box.getAt(key);
//   }

//   @override
//   Future<int> add(dynamic value) {
//     return box.add(value);
//   }

//   @override
//   Future<int> clear() {
//     return box.clear();
//   }

//   @override
//   Future<void> delete(dynamic value) {
//     return box.delete(value);
//   }

//   @override
//   Future<void> putAll(Map<String, dynamic> entries) async {
//     return box.putAll(entries);
//   }
// }

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage._();

  // Singleton instance
  static final SecureStorage _instance = SecureStorage._();

  // Factory constructor to return the same instance every time
  factory SecureStorage() => _instance;

  final _storage = const FlutterSecureStorage(

      // iOptions: IOSOptions.defaultOptions,
      // aOptions: AndroidOptions.defaultOptions,
      );

  Future<void> saveUserEmail(String userEmail) async {
   await _storage.write(key: 'user_email', value: userEmail);
  }

  Future<String?> getUserEmail() async {
    String? value = await _storage.read(key: 'user_email');
    return value;
  }

  Future<void> saveUserForgotPasswordCode(String userEmail) async {
   await _storage.write(key: 'code', value: userEmail);
  }

  Future<String?> getUserForgotPasswordCode() async {
    String? value = await _storage.read(key: 'code');
    return value;
  }

  Future<void> saveUserFirstName(String userEmail) async {
  await  _storage.write(key: 'firstName', value: userEmail);
  }

  Future<String?> getUserFirstName() async {
    String? value = await _storage.read(key: 'firstName');
    return value;
  }

  Future<void> saveUserPassword(String userPassword) async {
   await _storage.write(key: 'user_password', value: userPassword);
  }

  Future<String?> getUserPassword() async {
    String? value = await _storage.read(key: 'user_password');
    return value;
  }

  Future<void> saveUserToken(String token) async {
   await _storage.write(key: 'token', value: token);
  }

  Future<String?> getUserToken() async {
    String? value = await _storage.read(key: 'token');
    return value;
  }


  Future<void> saveUserApiKey(String token) async {
   await _storage.write(key: 'api_key', value: token);
  }

  Future<String?> getUserApiKey() async {
    String? value = await _storage.read(key: 'api_key');
    return value;
  }

  Future<void> saveResetPasswordToken(String token) async {
  await  _storage.write(key: 'token', value: token);
  }

  Future<String?> getResetPasswordToken() async {
    String? value = await _storage.read(key: 'token');
    return value;
  }

  Future<void> saveUserId(int id) async {
  await  _storage.write(key: 'id', value: id.toString());
  }

  Future<String?> getUserId() async {
    String? value = await _storage.read(key: 'id');
    return value;
  }

  Future<void> saveUserAccountName(String userEmail) async {
  await  _storage.write(key: 'user_account_name', value: userEmail);
  }

  Future<String?> getUserAccountName() async {
    String? value = await _storage.read(key: 'user_account_name');
    return value;
  }

  // Future<void> saveUserDetails(
  //     AccountOwnerProfileData accountOwnerProfileData) async {
  //   String jsonString = jsonEncode(accountOwnerProfileData.toJson());
  //   await _storage.write(key: 'user_details', value: jsonString);
  // }

  // Future<AccountOwnerProfileData?> getUserDetails() async {
  //   String? jsonString = await _storage.read(key: 'user_details');
  //   if (jsonString != null) {
  //     Map<String, dynamic> jsonMap = jsonDecode(jsonString);
  //     return AccountOwnerProfileData.fromJson(jsonMap);
  //   }
  //   return null;
  // }
}

final localStorageProvider = Provider<SecureStorage>(
  (ref) => SecureStorage(),
);
