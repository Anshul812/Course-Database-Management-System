import 'package:course_management_system/constants.dart';
import 'package:course_management_system/course_data.dart';
import 'package:course_management_system/google_sign.dart';
import 'package:course_management_system/user.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CDMS"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                signOutGoogle();
                Constants.prefs.setBool("loggedin", false);
                Navigator.pushReplacementNamed(context, '/home');
              })
        ],
      ),
      body: CourseData(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/courseadd');
        },
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
        child: User(
            Constants.prefs.getString("uname"),
            Constants.prefs.getString("uemail"),
            Constants.prefs.getString("uphoto")),
      ),
    );
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Sign Out");
  }
}
