// ignore_for_file: file_names, unused_local_variable, avoid_print, non_constant_identifier_names
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_f99/firestore/edit.dart';
import 'package:task_f99/firestore/sub_coll/home_sub.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
          .collection('users')
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

//////////////////////////////////////////////////////////////////
  Future<void> sub_deleteInFirebase(int i) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(data[i]['id'])
          .delete();
      setState(() {
        data.removeAt(i);
      });
    } catch (e) {
      print("Error deleting data: $e");
    }
  }
/////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.of(context).pushNamed("add_page");
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
        child: GridView.builder(
            itemCount: data.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, i) {
              return InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> home_sub(docid: data[i]['id'], name_appbar: data[i]["name"] ,)));
                },
                onLongPress: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.question,
                    animType: AnimType.bottomSlide,
                    title: "What do you want to choose?",
                    btnOkText: "Edit",
                    btnCancelText: "Delete",
                    btnOkOnPress: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditFirebase(
                              docid: data[i]['id'], Oldname: data[i]["name"])));
                    },
                    btnCancelOnPress: ()  {
                      sub_deleteInFirebase(i);
                    },
                  ).show();
                },
                child: Card(
                  elevation: 10,
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Color.fromARGB(255, 161, 54, 232),
                          Color.fromARGB(255, 42, 155, 192),
                        ])),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Center(child: Text("${data[i]['name']}"))],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
