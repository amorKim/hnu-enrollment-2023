import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hnu_mis_announcement/services/cloud/cloud_storage_constants.dart';

class Enrollment {
  final String documentId;
  final String courseCode;
  final String courseId;
  final Map<String, dynamic> schedule;
  final Map<String, dynamic>? scheduleLab;
  final String? studGrade;
  final String studentId;

  Enrollment({
    required this.documentId,
    required this.courseCode,
    required this.courseId,
    required this.studentId,
    required this.schedule,
    required this.studGrade,
    this.scheduleLab,
  });

  Enrollment.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        courseCode = snapshot.data()[enrollmentCourseCodeFieldName],
        courseId = snapshot.data()[enrollmentCourseIdFieldName],
        schedule = snapshot.data()[enrollmentCourseScheduleFieldName],
        scheduleLab = snapshot.data()[enrollmentCourseScheduleLabFieldName],
        studentId = snapshot.data()[enrollmentStudentIdFieldName],
        studGrade = snapshot.data()[enrollmentStudentGradeFieldName];
}
