// ignore_for_file: no_leading_underscores_for_local_identifiers, camel_case_types, non_constant_identifier_names, file_names, unused_element, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_f99/nav_bar.dart';

class edit_sub extends StatefulWidget {
  final String subdocid;
  final String firstdocid;
  final String Oldname;
  const edit_sub({super.key, required this.subdocid, required this.Oldname, required this.firstdocid});

  @override
  State<edit_sub> createState() => _edit_subState();
}

class _edit_subState extends State<edit_sub> {
  final _sub_nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

   @override
  void initState() {
    super.initState();
    _sub_nameController.text = widget.Oldname;
  }


  @override
  void dispose() {
    _sub_nameController.dispose();
    super.dispose();
  }
//////////////////////////////////////////////////////////////////////////////////

  Future  edit_sub() {
    CollectionReference sub_coll = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.firstdocid)
        .collection('sub');
    return sub_coll.doc(widget.subdocid).update({
      "sub": _sub_nameController.text,
    }).then((value) => ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Data ADD successfully'))));
  }
//////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text(
          "edit in sub  Firebase",
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
              Color.fromARGB(255, 161, 54, 232),
            ])),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: _sub_nameController,
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
                        Color.fromARGB(255, 60, 151, 231)),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      edit_sub();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const hmoe_page()));
                      setState(() {});
                    }
                  },
                  child: const Text(
                    "edit",
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
