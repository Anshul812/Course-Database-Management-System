import 'dart:convert';

import 'package:course_management_system/constants.dart';
import 'package:course_management_system/course.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final String urlAdd =
    "https://abridged-latitude.000webhostapp.com/post_user.php";

final String urlRemove =
    "https://abridged-latitude.000webhostapp.com/remove_course.php";

class User extends StatefulWidget {
  final String _username;
  final String _useremail;
  final String _userphotoURL;

  User(this._username, this._useremail, this._userphotoURL);
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  List<Course> userCourses = new List();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(widget._username),
            accountEmail: Text(widget._useremail),
            currentAccountPicture: CircleAvatar(
              child: Image.network(widget._userphotoURL),
            ),
          ),
          Text(
            "${widget._username} registered for:",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blueGrey[300]),
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: userCourses == null ? 0 : userCourses.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    tileColor: index % 2 == 0
                        ? Colors.blueGrey[100]
                        : Colors.blueGrey[300],
                    leading: Text(
                      "${userCourses[index].department}",
                      style: TextStyle(
                          color: index % 2 == 0
                              ? Colors.blueGrey[300]
                              : Colors.blueGrey[100],
                          fontWeight: FontWeight.bold),
                    ),
                    title: Text("${userCourses[index].courseid}"),
                    subtitle: Text("${userCourses[index].coursename}"),
                    dense: true,
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: () {
                        _removeCourse(index);
                        Navigator.pushReplacementNamed(context, "/loggedin");
                      },
                      color: index % 2 == 0
                          ? Colors.blueGrey[300]
                          : Colors.blueGrey[100],
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    postData();
  }

  postData() async {
    var response = await http.post(urlAdd,
        body: {"username": widget._username, "userid": widget._useremail});
    userCourses = fromList(jsonDecode(response.body));
    print(userCourses.length);
    print(response.body);

    setState(() {});
  }

  Future<void> _removeCourse(int i) async {
    var response = await http.post(urlRemove, body: {
      "userid": Constants.prefs.getString("uemail"),
      "courseid": userCourses[i].courseid
    });

    print(response.body);
  }
}
