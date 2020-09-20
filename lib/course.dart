class Course {
  String courseid;
  String coursename;
  String department;
  String facultyname;

  Course({this.courseid, this.coursename, this.department, this.facultyname});
}

List<Course> fromList(List<dynamic> list) {
  List<Course> l = new List();
  for (int i = 0; i < list.length; i++) {
    l.add(Course(
        courseid: list[i]['courseid'],
        coursename: list[i]['coursename'],
        department: list[i]['department'],
        facultyname: list[i]['facultyname']));
  }

  return l;
}
