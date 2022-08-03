// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, use_build_context_synchronously, use_rethrow_when_possible

import 'package:chat_app_firebase/auth/auth_service.dart';
import 'package:chat_app_firebase/provider/userProvider.dart';
import 'package:chat_app_firebase/widgets/mainDraware.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../model/userModel.dart';

class UserProfilePage extends StatefulWidget {
  static const routeName = '/user-profile';

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final txtController = TextEditingController();

  @override
  void dispose() {
    txtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      drawer: MainDraware(),
      body: Center(
        child: Consumer<UserProvider>(
          builder: (context, provider, _) =>
              StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: provider.getUserByUId(AuthService.user!.uid),
            builder: (context, snapshort) {
              if (snapshort.hasData) {
                final userModel = UserModel.fromMap(snapshort.data!.data()!);
                return ListView(
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: userModel.image == null
                          ? Image.asset(
                              'images/R.png',
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              userModel.image!,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                    ),
                    TextButton.icon(
                      onPressed: _updateImage,
                      icon: Icon(Icons.camera),
                      label: Text('Change Image'),
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 1,
                    ),
                    ListTile(
                      title: Text(userModel.name ?? 'No Display name'),
                      trailing: IconButton(
                          onPressed: () {
                            showInputDialog(
                              'Display name',
                              userModel.name,
                              (value) async {
                                await provider.updateProfile(
                                    AuthService.user!.uid, {'name': value});
                                await AuthService.updateDisplayNamer(value);
                              },
                            );
                          },
                          icon: Icon(Icons.edit)),
                    ),
                    ListTile(
                      title: Text(userModel.email ?? 'No Email Address'),
                      trailing: IconButton(
                          onPressed: () {
                            showInputDialog('Email address', userModel.email,
                                (value) {
                              provider.updateProfile(
                                  AuthService.user!.uid, {'email': value});
                            });
                          },
                          icon: Icon(Icons.edit)),
                    ),
                    ListTile(
                      title: Text(userModel.mobile ?? 'No Mobile Number'),
                      trailing: IconButton(
                          onPressed: () {
                            showInputDialog('Phone number', userModel.mobile,
                                (value) {
                              provider.updateProfile(
                                  AuthService.user!.uid, {'mobile': value});
                            });
                          },
                          icon: Icon(Icons.edit)),
                    ),
                  ],
                );
              }
              if (snapshort.hasError) {
                return Text('Failed to fetch data');
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  void _updateImage() async {
    final xFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 75);
    if (xFile != null) {
      try {
        final downloadUrl =
            await Provider.of<UserProvider>(context, listen: false)
                .updateImage(xFile);
        await Provider.of<UserProvider>(context, listen: false)
            .updateProfile(AuthService.user!.uid, {'image': downloadUrl});
        await AuthService.updateDisplayImage(downloadUrl);
      } catch (e) {
        throw e;
      }
    }
  }

  showInputDialog(String title, String? value, Function(String) onSave) {
    txtController.text = value ?? '';
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: txtController,
                  decoration: InputDecoration(hintText: 'Enter $title'),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Cancel')),
                TextButton(
                  onPressed: () {
                    onSave(txtController.text);
                    Navigator.of(context).pop();
                  },
                  child: Text('Update'),
                ),
              ],
            ));
  }
}
