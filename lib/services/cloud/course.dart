import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hnu_mis_announcement/services/cloud/cloud_storage_constants.dart';

class Course {
  final String documentId;
  final String courseCode;
  final String courseName;
  final String teacherName;
  final int maxEnroll;
  final int payUnit;
  final int loadUnit;
  final Map<String, dynamic> schedule;
  final Map<String, dynamic>? scheduleLab;

  Course({
    required this.documentId,
    required this.courseCode,
    required this.courseName,
    required this.loadUnit,
    required this.teacherName,
    required this.maxEnroll,
    required this.payUnit,
    required this.schedule,
    this.scheduleLab,
  });

  Course.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        courseCode = snapshot.data()[courseCodeFieldName],
        courseName = snapshot.data()[courseNameFieldName],
        loadUnit = snapshot.data()[courseloadUnitFieldName],
        teacherName = snapshot.data()[courseTeacherNameFieldName],
        maxEnroll = snapshot.data()[courseMaxUnitFieldName],
        payUnit = snapshot.data()[coursePayUnitFieldName],
        schedule = snapshot.data()[courseScheduleFieldName],
        scheduleLab = snapshot.data()[courseScheduleLabFieldName];
}
