import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  final String? id;
  final String name;
  final String deadline;
  final String source;

  Course(
      {required this.id,
      required this.name,
      required this.deadline,
      required this.source});

}
