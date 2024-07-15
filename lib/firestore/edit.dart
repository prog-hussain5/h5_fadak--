// ignore_for_file: no_leading_underscores_for_local_identifiers, camel_case_types, non_constant_identifier_names, file_names, unused_element, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_f99/nav_bar.dart';

class EditFirebase extends StatefulWidget {
  final String docid;
  final String Oldname;
  const EditFirebase({super.key, required this.docid, required this.Oldname});

  @override
  State<EditFirebase> createState() => _EditFirebaseState();
}

class _EditFirebaseState extends State<EditFirebase> {
  final _editInFirebaseController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _editInFirebaseController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _editInFirebaseController.text = widget.Oldname;
  }

////////////////////////////////////////////////////////////
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> EditUser() async {
    await users
        .doc(widget.docid)
        .update({"name": _editInFirebaseController.text}).then((value) =>
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data Edit successfully'))));
  }

//////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text(
          "Edit in Firebase",
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
            ])),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: _editInFirebaseController,
                  decoration: const InputDecoration(
                    labelText: 'Edit',
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
                        Color.fromARGB(255, 60, 151, 231)),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      EditUser();
                       Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const hmoe_page()));
                      setState(() {});
                    }
                  },
                  child: const Text(
                    "Edit ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
