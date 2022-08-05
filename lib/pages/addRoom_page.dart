import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/userProvider.dart';

class AddRoomPage extends StatefulWidget {
  static const routeName = '/add-room';

  @override
  State<AddRoomPage> createState() => _AddRoomPageState();
}

class _AddRoomPageState extends State<AddRoomPage> {
  final roomNameController = TextEditingController();
  bool isInit = true;
  bool Cliclable = false;

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
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        title: Text('Create Room'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: roomNameController,
              cursorColor: Color(0xff63BF96),
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                  color: Color(0xff63BF96), fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.only(left: 10),
                focusColor: Colors.white,
                prefixIcon: Icon(
                  Icons.person,
                  color: Color(0xff63BF96),
                ),
                hintText: "Enter Group name",
                hintStyle: TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.normal),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Expanded(
              child: Consumer<UserProvider>(
                builder: (context, provider, _) => ListView.builder(
                  itemCount: provider.AllUserList.length,
                  itemBuilder: (context, index) {
                    final user = provider.AllUserList[index];
                    return ListTile(
                      onTap: () {
                        setState(() {
                          Cliclable = !Cliclable;
                        });
                      },
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: user.image == null
                            ? Image.asset(
                                'R.png',
                                height: 30,
                                width: 30,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                user.image!,
                                height: 30,
                                width: 30,
                                fit: BoxFit.cover,
                              ),
                      ),
                      title: Text(user.name == null ? user.email! : user.name!),
                      trailing: Icon(
                        Icons.circle,
                        color: Cliclable ? Colors.green : Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Create'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
