import 'package:chat_app_firebase/auth/auth_service.dart';
import 'package:chat_app_firebase/db/dbHelper.dart';
import 'package:chat_app_firebase/provider/userProvider.dart';
import 'package:chat_app_firebase/widgets/mainDraware.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addRoom_page.dart';

class UserListPage extends StatefulWidget {
  static const routeName = '/user-list';

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<UserProvider>(context, listen: false).getAllUsers();
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Users'),
      ),
      drawer: MainDraware(),
      body: Consumer<UserProvider>(
        builder: (context, provider, _) => ListView.builder(
          itemCount: provider.AllUserList.length,
          itemBuilder: (context, index) {
            final user = provider.AllUserList[index];
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: user.image==null ?
                Image.asset('R.png', height: 30, width: 30, fit: BoxFit.cover,) :
                Image.network(user.image!, height: 30, width: 30, fit: BoxFit.cover,),
              ),
              title: Text(user.name==null ? user.email! : user.name!),
              trailing: Icon(Icons.circle, color: user.available ? Colors.green : Colors.red,),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddRoomPage.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


