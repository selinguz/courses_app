import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

DatabaseReference ref = FirebaseDatabase.instance.ref("courses");

class Course {
  final String id;
  final String name;
  final String deadline;
  final String source;

  Course(
      {required this.id,
      required this.name,
      required this.deadline,
      required this.source});

  void addCourse() {
    FirebaseFirestore.instance
        .collection('courses')
        .add({"name": name, "id": id, "deadline": deadline, "source": source});
  }
}
