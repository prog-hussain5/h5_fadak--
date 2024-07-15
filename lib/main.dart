import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_f99/firebase/auth.dart';
import 'package:task_f99/firebase/login.dart';
import 'package:task_f99/firebase/signup.dart';
import 'package:task_f99/firestore/Add.dart';
import 'package:task_f99/firestore/Home.dart';
import 'package:task_f99/firestore/profile.dart';
import 'package:task_f99/nav_bar.dart';

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
      initialRoute:"/",
      routes: {
        "/":(context) => const Auth(),
        "sinUp_screens":(context) => const signup_screen(),
        "login_screens":(context) => const login_screen(),
        "add_page":(context) => const AddFirebase(),
        "Home":(context) => const Home(),
        "hmoe_page":(context) => const hmoe_page(),
        "view_profile":(context) => const F_profile(),
      },
    );
  }
}



