// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:task_f99/firebase/profile.dart';
import 'package:task_f99/firestore/Home.dart';
import 'package:task_f99/firestore/profile.dart';


class hmoe_page extends StatefulWidget {
  const hmoe_page({super.key});

  @override
  State<hmoe_page> createState() => _hmoe_pageState();
}

class _hmoe_pageState extends State<hmoe_page> {
////
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Home(),
    const Profile(),
    const F_profile()

  ];
/////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text(
          "Hello Fadak  🦉🐈 ^_^",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 161, 54, 232),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child:  GNav(
          gap: 40,
          activeColor: Colors.white,
          iconSize: 25,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: Colors.blueAccent,
          color: Colors.black,
          tabs:  const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),

            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
             GButton(
              icon: Icons.person,
              text: 'f_Profile',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    )
    );
  }
}
