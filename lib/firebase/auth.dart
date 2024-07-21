// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:task_f99/firebase/login.dart';
import 'package:task_f99/nav_bar.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  void initState() {
    super.initState();
    getToken();
  }

  Future<void> getToken() async {
    String? myToken = await FirebaseMessaging.instance.getToken();
    print("=================================================");
    print(myToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const hmoe_page(); 
          } else {
            return const login_screen();
          }
        },
      ),
    );
  }
}
