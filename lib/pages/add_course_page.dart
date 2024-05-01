import 'package:egitimlerim/course.dart';
import 'package:flutter/material.dart';

import '../consts.dart';

class AddCoursePage extends StatefulWidget {
  const AddCoursePage({super.key});

  @override
  State<AddCoursePage> createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  final courseNameController = TextEditingController();
  final courseTimeController = TextEditingController();
  final courseSourceController = TextEditingController();

  static const snackBar = SnackBar(
    content: Text('Tüm alanlar doldurulmalı'),
    duration: Duration(seconds: 2),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: scaffoldColor,
        appBar: AppBar(
          backgroundColor: appBarColor,
          toolbarHeight: 90.0,
          title: const Text(
            'Eğitim Ekle',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Form(
          child: Column(
            children: [
              CourseTextField(
                controller: courseNameController,
                hintText: "Eğitim Adı",
              ),
              CourseTextField(
                controller: courseTimeController,
                hintText: "Bitirme Süresi",
              ),
              CourseTextField(
                controller: courseSourceController,
                hintText: "Kaynak",
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    height: 64.0,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      onPressed: () {
                        if (courseNameController.text == "" ||
                            courseTimeController.text == "" ||
                            courseSourceController.text == "") {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          Course.addCourse(
                              name: courseNameController.text,
                              deadline: courseTimeController.text,
                              source: courseSourceController.text);
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text(
                        'Kaydet',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CourseTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const CourseTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hintText,
        ),
      ),
    );
  }
}
