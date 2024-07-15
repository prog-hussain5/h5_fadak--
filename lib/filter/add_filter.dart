// ignore_for_file: no_leading_underscores_for_local_identifiers, camel_case_types, non_constant_identifier_names, file_names, unused_element, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_f99/nav_bar.dart';

class AddFirebase_filttering extends StatefulWidget {
  const AddFirebase_filttering({super.key});

  @override
  State<AddFirebase_filttering> createState() => _AddFirebase_filtteringState();
}

class _AddFirebase_filtteringState extends State<AddFirebase_filttering> {
  final _addnameInFirebaseController = TextEditingController();
  final _addAgeInFirebaseController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
 
  @override
  void dispose() {
    _addnameInFirebaseController.dispose();
    _addAgeInFirebaseController.dispose();
    super.dispose();
  }



  //////////////////////////////////////////////////////////////////////////////////
  CollectionReference users = FirebaseFirestore.instance.collection('filtter');

  Future<void> addUser() {
    return users.add({
      "name": _addnameInFirebaseController.text,
      "age": _addAgeInFirebaseController.text,
      "id": FirebaseAuth.instance.currentUser!.uid
    }).then((value) => ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Data ADD successfully'))));
  }

  //////////////////////////////////////////////////////////////////////////////////
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      controller: _addnameInFirebaseController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _addAgeInFirebaseController,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.view_agenda),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 60, 151, 231)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          addUser();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const hmoe_page()));
                          setState(() {});
                        }
                      },
                      child: const Text(
                        "ADD TO Filttering",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      )),
                  const Divider(
                    height: 20,
                    indent: 30,
                    endIndent: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
