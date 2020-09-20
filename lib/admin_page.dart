import 'package:course_management_system/constants.dart';
import 'package:course_management_system/course.dart';
import 'package:course_management_system/course_data.dart';
import 'package:course_management_system/google_sign.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<Course> courseList = new List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CDMS",
          style: TextStyle(color: Colors.grey[200]),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.person_add),
              onPressed: () {
                signInWIthGoogle().whenComplete(() {
                  Constants.prefs.setBool("loggedin", true);
                  Navigator.pushReplacementNamed(context, '/loggedin');
                });
              })
        ],
      ),
      body: CourseData(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 10.0,
        child: Icon(Icons.sort),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
