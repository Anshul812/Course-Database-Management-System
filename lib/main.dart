import 'package:course_management_system/admin_page.dart';
import 'package:course_management_system/constants.dart';
import 'package:course_management_system/user_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:course_management_system/course_add.dart';

Future main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  Constants.prefs = await SharedPreferences.getInstance();
  Firebase.initializeApp();
  runApp(MyApp());
}

final routes = {
  '/home': (BuildContext context) => AdminPage(),
  '/loggedin': (BuildContext context) => UserPage(),
  '/courseadd': (BuildContext context) => CourseAdd()
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CDMS",
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: Constants.prefs.getBool("loggedin") == true
          ? UserPage()
          : AdminPage(),
      routes: routes,
    );
  }
}
