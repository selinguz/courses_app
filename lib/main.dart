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
  static const appBarColor = Color(0xFF006d77);
  static const scaffoldColor = Color(0xfFedf6f9);

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
            title: Text('Eğitimlerim',style: TextStyle(color: Colors.white),),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top:12.0,left:12.0,right: 12.0),
            child: ColoredBox(
              color: Color(0xFFedf6f9),
              child: Column(
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: courses.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          separatorBuilder: (BuildContext context, int index) => const Divider(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Color(0xFF83c5be),
                              shape: RoundedRectangleBorder(borderRadius: 
                              BorderRadius.circular(12.0)),
                              child: ListTile(
                                //tileColor: Color(0xFFDCB6D5),
                                leading: const Icon(
                                  Icons.list_rounded,
                                ),
                                title: Text(snapshot.data!.docs[index]['name']),
                                subtitle:
                                    Text(snapshot.data!.docs[index]['deadline']),
                                trailing: Icon(Icons.more_vert),
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
