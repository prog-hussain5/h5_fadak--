// ignore_for_file: camel_case_types, avoid_print, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_f99/firestore/profile_add.dart';

class F_profile extends StatefulWidget {
  const F_profile({super.key});

  @override
  State<F_profile> createState() => _F_profileState();
}

class _F_profileState extends State<F_profile> {
  late List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    getData_in_profile();
  }

  Future<void> getData_in_profile() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('profile')
          .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          if (data.isNotEmpty) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProfileEditPage(
                name: data[0]["name"],
                Phone: data[0]["Phone"],
                Age: data[0]["Age"],
                Bio: data[0]["Bio"],
              ),
            ));
          }
        },
        child: const Icon(
          Icons.add,
          color: Colors.purple,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(255, 42, 155, 192),
              Color.fromARGB(255, 161, 54, 232)
            ])),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, i) {
                  return Card(
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: data[i]["name"],
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
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: data[i]["Phone"],
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.phone),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: data[i]["Age"],
                          decoration: const InputDecoration(
                            labelText: 'Age',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your age';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: data[i]["Bio"],
                          decoration: const InputDecoration(
                            labelText: 'Bio',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.description),
                          ),
                          maxLines: 5,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your bio';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
