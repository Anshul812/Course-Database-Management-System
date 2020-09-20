import 'dart:convert';
import 'package:course_management_system/constants.dart';
import 'package:course_management_system/course.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final String urlAdd = "https://abridged-latitude.000webhostapp.com/get_add.php";

final String urlPost =
    "https://abridged-latitude.000webhostapp.com/add_courses.php";

class CourseAdd extends StatefulWidget {
  @override
  _CourseAddState createState() => _CourseAddState();
}

class _CourseAddState extends State<CourseAdd> {
  List<bool> _checkList = new List();
  List<Course> courseList = new List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Course"),
      ),
      body: ListView.builder(
        itemCount: courseList.isNotEmpty ? courseList.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: CheckboxListTile(
                value: _checkList[index],
                onChanged: (value) {
                  setState(() {
                    if (_checkList[index]) {
                      _checkList[index] = false;
                    } else {
                      _checkList[index] = true;
                    }
                  });
                },
                title: Text(courseList[index].courseid),
                subtitle: Text(courseList[index].coursename),
                secondary: Text(
                  courseList[index].department,
                  style: TextStyle(
                      color: Colors.blueGrey[600], fontWeight: FontWeight.bold),
                ),
                controlAffinity: ListTileControlAffinity.platform,
                dense: true,
                activeColor: Colors.blueGrey[900],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCourses,
        child: Text(
          "Add",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var response = await http
        .post(urlAdd, body: {"uid": Constants.prefs.getString("uemail")});
    courseList = fromList(jsonDecode(response.body));
    print(courseList.length);

    print(response.body);
    for (int i = 0; i < courseList.length; i++) _checkList.add(false);
    setState(() {});
  }

  _addCourses() async {
    List<String> _newCoursesid = new List();

    for (int i = 0; i < _checkList.length; i++) {
      if (_checkList[i] == true) {
        _newCoursesid.add(courseList[i].courseid);
      }
    }
    var response = await http.post(urlPost,
        body: jsonEncode({
          "uid": Constants.prefs.getString("uemail"),
          "ucourses": _newCoursesid
        }));

    print(response.body);
    Navigator.pop(context);
  }
}
