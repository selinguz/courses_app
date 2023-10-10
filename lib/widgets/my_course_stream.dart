import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyCourseStream extends StatelessWidget {
  final String docName;

  const MyCourseStream({
    super.key,
    required this.docName,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection("courses")
          .doc(docName)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    leading: const Icon(Icons.list),
                    trailing: MyCourseStream(docName: 'BSODVA7kFnKqTKcaRHM1'),
                    title: Text("List item $index"));
              });
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
