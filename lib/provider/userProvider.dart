import 'dart:io';

import 'package:chat_app_firebase/db/dbHelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../model/userModel.dart';

class UserProvider extends ChangeNotifier {
  List<UserModel> userList = [];
  List<UserModel> AllUserList = [];

  Future<void> addUser(UserModel userModel) => DBHelper.addUser(userModel);

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserByUId(String uid) =>
      DBHelper.getUserByUId(uid);

  getAllUsers() {
    DBHelper.getAllUsers().listen((snapshort) {
      AllUserList = List.generate(snapshort.docs.length,
          (index) => UserModel.fromMap(snapshort.docs[index].data()));
      notifyListeners();
    });
  }

  Future<void> updateProfile(String uid, Map<String, dynamic> map) =>
      DBHelper.updateProfile(uid, map);

  Future<String> updateImage(XFile xFile) async {
    final imagename = DateTime.now().millisecondsSinceEpoch.toString();
    final photoRefarance =
        FirebaseStorage.instance.ref().child('pictures/$imagename');
    final uploadtask = photoRefarance.putFile(File(xFile.path));
    final snapshort = await uploadtask.whenComplete(() => null);
    return snapshort.ref.getDownloadURL();
  }
}
