import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egitimlerim/consts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyHome());
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CollectionReference courses =
      FirebaseFirestore.instance.collection('courses');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: scaffoldColor,
          appBar: AppBar(
            backgroundColor: appBarColor,
            toolbarHeight: 90.0,
            title: const Text(
              'Eğitimlerim',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
            child: ColoredBox(
              color: scaffoldColor,
              child: Column(
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: courses.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                            color: appBarColor,
                            thickness: 2.0,
                            indent: 5.0,
                            endIndent: 5.0,
                          ),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: cardColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.list_rounded,
                                ),
                                title: Text(snapshot.data!.docs[index]['name']),
                                subtitle: Text(
                                    snapshot.data!.docs[index]['deadline']),
                                trailing: const Icon(Icons.more_vert),
                              ),
                            );
                          },
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
