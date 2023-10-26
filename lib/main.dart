import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egitimlerim/consts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'pages/courses_page.dart';

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
    return const MaterialApp(
      home: CoursesPage(),
    );
  }
}
