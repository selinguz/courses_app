import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egitimlerim/widgets/my_course_stream.dart';
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
  // This widget is the root of your application.
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
          body: Container(
            child: SizedBox(
              child: Column(
                children: [
                  MyCourseStream(docName: 'BSODVA7kFnKqTKcaRHM1'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
