// ignore_for_file: camel_case_types, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class view_filtter extends StatefulWidget {
  const view_filtter({super.key});

  @override
  State<view_filtter> createState() => _view_filtterState();
}

class _view_filtterState extends State<view_filtter> {
  late List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    getData();
    setState(() {});
    super.initState();
  }

  ///////////////////////////////////////////////////////////////////////
  Future<void> getData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('filtter').orderBy("age",descending: true)
          .get();
      setState(() {
        data = querySnapshot.docs.map((doc) {
          var docData = doc.data() as Map<String, dynamic>;
          docData['id'] = doc.id;
          return docData;
        }).toList();
      });
    } catch (e) {
      print("Error getting data: $e");
    }
  }

  //////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(255, 52, 170, 189),
              Color.fromARGB(255, 161, 54, 232)
            ])),
        child: Expanded(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
              return Card(
                child: ListTile(
                  title: Text(data[i]['name']),
                  subtitle: Text(data[i]['age']),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
