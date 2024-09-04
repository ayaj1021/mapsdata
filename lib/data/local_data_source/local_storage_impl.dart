// import 'dart:async';

// import 'package:digit_send/data/local_data_source/local_storage.dart';
// import 'package:digit_send/data/local_data_source/storage_keys.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hive_flutter/hive_flutter.dart';

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

// final localStorageProvider = Provider<LocalStorage>(
//   (ref) => LocalStorageImpl(Hive.box(HiveKeys.appBox)),
// );
