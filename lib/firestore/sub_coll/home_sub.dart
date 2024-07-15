// ignore_for_file: file_names, unused_local_variable, avoid_print, camel_case_types, non_constant_identifier_names
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_f99/firestore/sub_coll/add_sub.dart';
import 'package:task_f99/firestore/sub_coll/edit_sub.dart';

class home_sub extends StatefulWidget {
  final String docid;
  final String name_appbar;
  const home_sub({super.key, required this.docid, required this.name_appbar});

  @override
  State<home_sub> createState() => _home_subState();
}

class _home_subState extends State<home_sub> {
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
          .doc(widget.docid)
          .collection('sub')
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
//////////////////////////////////////////////////////////////////
  Future<void> deleteInFirebase(int i) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.docid)
          .collection('sub')
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
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text(
          widget.name_appbar,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => add_sub(docid: widget.docid)));
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
                          builder: (context) => edit_sub(
                                subdocid: data[i]['id'],
                                Oldname: data[i]['sub'],
                                firstdocid: widget.docid,
                              )));
                    },
                    btnCancelOnPress: () {
                      deleteInFirebase(i);
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
                      children: [Center(child: Text("${data[i]['sub']}"))],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
