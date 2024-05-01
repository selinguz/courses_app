import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egitimlerim/pages/add_course_page.dart';
import 'package:egitimlerim/widgets/search_bar.dart';
import 'package:flutter/material.dart';

import '../consts.dart';
import '../course.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  TextEditingController searchController = TextEditingController();
  int courseCount = 0;
  CollectionReference courses =
      FirebaseFirestore.instance.collection('courses');

  Future<int> countCourses() async {
    AggregateQuerySnapshot query = await courses.count().get();
    setState(() {
      courseCount = query.count;
    });
    return courseCount;
  }

  @override
  void initState() {
    countCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    countCourses();
    return SafeArea(
      child: Scaffold(
        backgroundColor: scaffoldColor,
        appBar: AppBar(
          backgroundColor: appBarColor,
          toolbarHeight: 90.0,
          title: const Text(
            'Eğitimlerim',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SearchInput(textController: searchController, hintText: "Search"),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text('$courseCount adet eğitim listeleniyor'),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
                child: ColoredBox(
                  color: scaffoldColor,
                  child: Column(
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: courses.snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(
                                color: appBarColor,
                                thickness: 2.0,
                                indent: 5.0,
                                endIndent: 5.0,
                              ),
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  color: cardColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.list_rounded,
                                    ),
                                    title: Text(
                                        snapshot.data!.docs[index]['name']),
                                    subtitle: Text(
                                        snapshot.data!.docs[index]['deadline']),
                                    trailing: DropDownMenu(
                                      color: scaffoldColor,
                                      docId: snapshot.data!.docs[index].id,
                                    ),
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
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddCoursePage()),
            );
          },
          backgroundColor: appBarColor,
          splashColor: scaffoldColor,
          elevation: 12,
          child: const Icon(
            Icons.add,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}

class DropDownMenu extends StatelessWidget {
  final Color color;
  final Widget icon;
  final String docId;

  const DropDownMenu(
      {this.color = Colors.white,
      required this.docId,
      this.icon = const Icon(
        Icons.more_vert,
        color: Color(0xff4338CA),
      ),
      super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: color,
      icon: icon,
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.update, color: Colors.blue[400]),
            title: const Text('Güncelle'),
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            onTap: () {
              Course.deleteCourse('courses', docId);
            },
            leading: Icon(Icons.delete, color: Colors.red[400]),
            title: const Text('Sil'),
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(child: Text('More Information')),
      ],
    );
  }
}
