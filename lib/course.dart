import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
/*  final String name;
  final String deadline;
  final String source;*/

  _Course() {
    throw UnimplementedError();
  }

  static Future<void> addCourse(
      {required String name,
      required String deadline,
      required String source}) async {
    await FirebaseFirestore.instance
        .collection("courses")
        .add({'name': name, "deadline": deadline, "source": source});
  }

  static Future<void> deleteCourse(String collection, String documentId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection(collection).doc(documentId).delete();
      print('Belge başarıyla silindi.');
    } catch (e) {
      print('Belge silinirken hata oluştu: $e');
    }
  }
}
