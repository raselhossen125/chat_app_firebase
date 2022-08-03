import 'package:chat_app_firebase/model/message_model.dart';
import 'package:chat_app_firebase/model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DBHelper {
  static const String collectionUsers = 'Users';
  static const String collectionRoomMessage = 'ChatRoomMessage';

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addUser(UserModel userModel) {
    final doc = _db.collection(collectionUsers).doc(userModel.uid);
    return doc.set(userModel.toMap());
  }

  static Future<void> addMessage(MessageModel messageModel) {
    return _db
        .collection(collectionRoomMessage)
        .doc()
        .set(messageModel.toMap());
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserByUId(
          String uid) =>
      _db.collection(collectionUsers).doc(uid).snapshots();

  static Future<DocumentSnapshot<Map<String, dynamic>>> getUserByUIdFuture(
          String uid) =>
      _db.collection(collectionUsers).doc(uid).get();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllChatRoomMessages() =>
      _db
          .collection(collectionRoomMessage)
          .orderBy('msgId', descending: true)
          .snapshots();

  static Future<void> updateProfile(String uid, Map<String, dynamic> map) {
    return _db.collection(collectionUsers).doc(uid).update(map);
  }
}
