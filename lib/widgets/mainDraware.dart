// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:chat_app_firebase/auth/auth_service.dart';
import 'package:chat_app_firebase/pages/chatRoom_page.dart';
import 'package:chat_app_firebase/pages/launcher_page.dart';
import 'package:chat_app_firebase/pages/userList_page.dart';
import 'package:chat_app_firebase/pages/userProfile_page.dart';
import 'package:flutter/material.dart';

import '../db/dbHelper.dart';

class MainDraware extends StatelessWidget {
  const MainDraware({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 200,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacementNamed(context, UserProfilePage.routeName);
            },
            leading: Icon(Icons.person),
            title: Text('My Profile'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacementNamed(context, ChatRoomPage.routeName);
            },
            leading: Icon(Icons.chat),
            title: Text('Chat Room'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacementNamed(context, UserListPage.routeName);
            },
            leading: Icon(Icons.person),
            title: Text('User List'),
          ),
          ListTile(
            onTap: () async{
              if (AuthService.user != null) {
                DBHelper.updateProfile(AuthService.user!.uid, {'available' : false});
              }
              await AuthService.logOut();
              Navigator.pushReplacementNamed(context, LauncherPage.routeName);
            },
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
          ),
        ],
      ),
    );
  }
}
