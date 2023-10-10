import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance
      .collection("courses")
      .doc("course1")
      .set({"name": "Flutter", "deadline": "20 Ekim"});
  runApp(const MyHome());
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  //final String docName= ' ';
  CollectionReference courses =
      FirebaseFirestore.instance.collection('courses');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.orange[100],
          appBar: AppBar(
            toolbarHeight: 90.0,
            title: Text('Eğitimlerim'),
          ),
          body: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: courses.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      separatorBuilder: (BuildContext context, int index) => new Divider(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          tileColor: Colors.amber,
                          leading: const Icon(
                            Icons.list_rounded,
                          ),
                          title: Text(snapshot.data!.docs[index]['name']),
                          subtitle:
                              Text(snapshot.data!.docs[index]['deadline']),
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
    );
  }
}
