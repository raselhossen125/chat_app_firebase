import 'package:chat_app_firebase/model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DBHelper {
  static const String collectionUsers = 'Users';

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addUser(UserModel userModel) {
    final doc = _db.collection(collectionUsers).doc(userModel.uid);
    return doc.set(userModel.toMap());
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserByUId(
          String uid) =>
      _db.collection(collectionUsers).doc(uid).snapshots();

  static Future<void> updateProfile(String uid, Map<String, dynamic> map) {
    return _db.collection(collectionUsers).doc(uid).update(map);
  }
}
