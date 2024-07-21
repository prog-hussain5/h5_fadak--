// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:task_f99/filter/add_filter.dart';
import 'package:task_f99/filter/view_filtter.dart';
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
    const F_profile(),
    const AddFirebase_filttering(),
    const view_filtter()


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
          gap: 5,
          activeColor: Colors.white,
          iconSize: 25,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
             GButton(
              icon: Icons.filter_1,
              text: 'filtter',
            ),
              GButton(
              icon: Icons.view_agenda,
              text: 'filtter',
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
