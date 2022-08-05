// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:chat_app_firebase/pages/addRoom_page.dart';
import 'package:chat_app_firebase/provider/chatRoom_provider.dart';
import 'package:chat_app_firebase/provider/userProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth/auth_service.dart';
import 'db/dbHelper.dart';
import 'pages/chatRoom_page.dart';
import 'pages/launcher_page.dart';
import 'pages/logIn_page.dart';
import 'pages/userList_page.dart';
import 'pages/userProfile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ChatRoomProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    if (AuthService.user != null) {
      DBHelper.updateProfile(AuthService.user!.uid, {'available' : true});
    }
    super.initState();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state) {
      case AppLifecycleState.paused:
        if (AuthService.user != null) {
          DBHelper.updateProfile(AuthService.user!.uid, {'available' : false});
        }
        break;
      case AppLifecycleState.resumed:
        if (AuthService.user != null) {
          DBHelper.updateProfile(AuthService.user!.uid, {'available' : true});
        }
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }
  @override
  Widget build(BuildContext context) {
    Map<int, Color> pokeballRedSwatch = {
      50: Color.fromARGB(255, 24, 1, 105),
      100: Color.fromARGB(255, 255, 88, 88),
      200: Color.fromARGB(255, 255, 88, 88),
      300: Color.fromARGB(255, 255, 88, 88),
      400: Color.fromARGB(255, 255, 88, 88),
      500: Color.fromARGB(255, 255, 88, 88),
      600: Color.fromARGB(255, 255, 88, 88),
      700: Color.fromARGB(255, 255, 88, 88),
      800: Color.fromARGB(255, 255, 88, 88),
      900: Color.fromARGB(255, 252, 70, 70),
    };
    MaterialColor pokeballRed = MaterialColor(0xff63BF96, pokeballRedSwatch);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: pokeballRed,
      ),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName: (_) => LauncherPage(),
        LogInPage.routeName: (_) => LogInPage(),
        UserProfilePage.routeName: (_) => UserProfilePage(),
        ChatRoomPage.routeName: (_) => ChatRoomPage(),
        UserListPage.routeName: (_) => UserListPage(),
        AddRoomPage.routeName: (_) => AddRoomPage(),
      },
    );
  }
}
