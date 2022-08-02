import 'package:chat_app_firebase/auth/auth_service.dart';
import 'package:chat_app_firebase/pages/launcher_page.dart';
import 'package:chat_app_firebase/pages/logIn_page.dart';
import 'package:flutter/material.dart';

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
            onTap: () async{
              await AuthService.logOut();
              Navigator.pushReplacementNamed(context, LauncherPage.routeName);
            },
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
          )
        ],
      ),
    );
  }
}
