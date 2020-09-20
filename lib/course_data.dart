import 'package:course_management_system/course.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String url =
    "https://abridged-latitude.000webhostapp.com/get_courses.php";

class CourseData extends StatefulWidget {
  @override
  _CourseDataState createState() => _CourseDataState();
}

class _CourseDataState extends State<CourseData> {
  List<Course> courseList = new List();
  final int show = 2;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: courseList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                tileColor: Colors.blueGrey[100],
                leading: CircleAvatar(
                  backgroundColor: index % 2 == 0
                      ? Colors.blueGrey[700]
                      : Colors.blueGrey[200],
                  child: Text(courseList[index].department[0]),
                ),
                title: Text(
                  courseList[index].courseid,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blueGrey[900], fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Prof : ${courseList[index].facultyname}"),
                    Text("Course Name : ${courseList[index].coursename}")
                  ],
                ),
                dense: true,
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var response = await http.get(url);
    courseList = fromList(jsonDecode(response.body));
    setState(() {});
  }
}
