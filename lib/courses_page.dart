
import 'package:flutter/material.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Eğitimlerim'),
        ),
        body: Container(
            //child: MyCourseStream(docName: 'BSODVA7kFnKqTKcaRHM1'),),
      ),
    ),);
  }
}

