import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hnu_mis_announcement/services/cloud/cloud_storage_constants.dart';

class Course {
  final String courseCode;
  final String courseName;
  final String teacherName;
  final int maxEnroll;
  final int payUnit;
  final Map<String, dynamic> schedule;

  Course({
    required this.courseCode,
    required this.courseName,
    required this.teacherName,
    required this.maxEnroll,
    required this.payUnit,
    required this.schedule,
  });

  Course.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : courseCode = snapshot.data()[courseCodeFieldName],
        courseName = snapshot.data()[courseNameFieldName],
        teacherName = snapshot.data()[courseTeacherNameFieldName],
        maxEnroll = snapshot.data()[courseMaxUnitFieldName],
        payUnit = snapshot.data()[coursePayUnitFieldName],
        schedule = snapshot.data()[courseScheduleFieldName];
}
