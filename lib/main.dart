// ignore_for_file: prefer_const_constructors
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_f99/firebase/auth.dart';
import 'package:task_f99/firebase/login.dart';
import 'package:task_f99/firebase/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/":(context) => Auth(),
        "sinUp_screens":(context) => signup_screen(),
        "login_screens":(context) => login_screen(),
      },
    );
  }
}



