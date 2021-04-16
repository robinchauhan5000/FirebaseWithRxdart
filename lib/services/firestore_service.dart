import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model_auth.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUser(UserModelAuth user) {
    return _db.collection('users').doc(user.userId).set(user.toJson());
  }

  Future<UserModelAuth> fetchUser(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .get()
        .then((snapshot) => UserModelAuth.fromJson(snapshot.data()));
  }
}
