

// class UserRepository {
//   UserRepository(this._storage, this.onUpdateuser);
//   final LocalStorage _storage;
//   final void Function(DSUser user) onUpdateuser;

//   DSUser getUser() {
//     final response = _storage.get<String?>(HiveKeys.user);
//     final user = DSUser.fromJson(
//       response == null
//           ? {}
//           : json.decode(response as String) as Map<String, dynamic>,
//     );
//     return user;
//   }

//   Future<void> updateUser(DSUser user) async {
//     await saveCurrentUser(user);
//     onUpdateuser(user);
//   }

//   Future<void> saveCurrentUser(DSUser val) async {
//     final js = val.toJson();
//     await _storage.put(HiveKeys.user, json.encode(js));
//   }
// }

// final userRepositoryProvider = Provider<UserRepository>(
//   (ref) => UserRepository(
//     ref.read(localStorageProvider),
//     (p0) {
//       ref.read(currentUserProvider.notifier).state = p0;
//     },
//   ),
// );

//final currentUserProvider = StateProvider<DSUser>((ref) {
 // final response = ref.read(localStorageProvider).get<String?>(HiveKeys.user);
 // final user = DSUser.fromJson(
    // response == null
    //     ? {}
    //     : json.decode(response as String) as Map<String, dynamic>,
 // );
  //return user;
//});
