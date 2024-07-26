import 'package:flutter/material.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/login1register/user_login_screen.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/userhomescreen.dart';
import 'app_open_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'All Götür',
      debugShowCheckedModeBanner: false,
      routes: {
        "/loginPage" : (context)=>UserLoginScreen(),
        "/userHomePage" : (context) => UserHomeScreen(),

      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AppOpenScreen(),
    );
  }
}
