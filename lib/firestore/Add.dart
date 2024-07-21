// ignore_for_file: no_leading_underscores_for_local_identifiers, camel_case_types, non_constant_identifier_names, file_names, unused_element, avoid_print, use_build_context_synchronously, unused_local_variable

import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_f99/nav_bar.dart';

class AddFirebase extends StatefulWidget {
  const AddFirebase({super.key});

  @override
  State<AddFirebase> createState() => _AddFirebaseState();
}

class _AddFirebaseState extends State<AddFirebase> {
  final _addInFirebaseController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? file;
  String? url;

  @override
  void dispose() {
    _addInFirebaseController.dispose();
    super.dispose();
  }

  getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      file = File(image.path);
      var imagename = basename(image.path);
      var storgeFileinFirebase = FirebaseStorage.instance.ref("images/").child(imagename);
      await storgeFileinFirebase.putFile(file!);
      url = await storgeFileinFirebase.getDownloadURL();
    } 
    setState(() {});
  }


  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(context) async {
    if (url == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add an image first'))
      );
      return;
    }
    
    await users.add({
      "name": _addInFirebaseController.text,
      "id": FirebaseAuth.instance.currentUser!.uid,
      "url": url ?? "no image",
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data added successfully'))
      );
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const hmoe_page()
      ));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add data: $error'))
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text(
          "Add in Firebase",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 52, 170, 189),
              Color.fromARGB(255, 161, 54, 232)
            ]
          )
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: _addInFirebaseController,
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
              const SizedBox(height: 16),
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 60, 151, 231)
                  ),
                ),
                onPressed: () async {
                  await getImage();
                },
                child: const Text(
                  "ADD image ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20
                  ),
                )
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 60, 151, 231)
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addUser(context);
                  }
                },
                child: const Text(
                  "ADD",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
