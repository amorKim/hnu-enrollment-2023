import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hnu_mis_announcement/services/cloud/cloud_storage_constants.dart';
import 'package:hnu_mis_announcement/services/cloud/cloud_storage_exceptions.dart';
import 'package:hnu_mis_announcement/services/cloud/course.dart';
import 'package:hnu_mis_announcement/services/cloud/enrollment.dart';
import 'package:hnu_mis_announcement/services/cloud/student.dart';
import 'package:intl/intl.dart';

class FirebaseCloudStorage {
  final students = FirebaseFirestore.instance.collection('students');
  final courses = FirebaseFirestore.instance.collection('courses_it');
  final enrollments = FirebaseFirestore.instance.collection('Enrollments');

  bool _hasScheduleConflict(
    Map<String, dynamic> schedule1,
    Map<String, dynamic> schedule2,
  ) {
    // If the schedules are on different days, there is no conflict
    if (schedule1['days'] != schedule2['days']) {
      return false;
    }

    final startTime1 = _parseTime(schedule1['start_time']);
    final endTime1 = _parseTime(schedule1['end_time']);
    final startTime2 = _parseTime(schedule2['start_time']);
    final endTime2 = _parseTime(schedule2['end_time']);

    // If the end time of one schedule is before the start time of the other, there is no conflict
    if (endTime1.isBefore(startTime2) || endTime2.isBefore(startTime1)) {
      return false;
    }

    // Otherwise, there is a conflict
    return true;
  }

  DateTime _parseTime(String timeStr) {
    final format = DateFormat('hh:mma');
    return format.parse(timeStr);
  }

  Future<Student> getStudent({required String ownerUserId}) async {
    try {
      final querySnapshot = await students
          .where(
            ownerUserIdFieldName,
            isEqualTo: ownerUserId,
          )
          .get();
      if (querySnapshot.docs.isEmpty) {
        throw StudentNotFoundException();
      }
      return Student.fromSnapshot(querySnapshot.docs.first);
    } catch (e) {
      throw e.toString();
    }
  }

  //get all course offered
  Stream<Iterable<Course>> allCourses() => courses
      .snapshots()
      .map((event) => event.docs.map((doc) => Course.fromSnapshot(doc)));

  //get all enrollments
  Stream<Iterable<Enrollment>> allEnrollmentsOfStudent(
          {required String userId}) =>
      enrollments
          .where(
            ownerUserIdFieldName,
            isEqualTo: userId,
          )
          .snapshots()
          .map(
              (event) => event.docs.map((doc) => Enrollment.fromSnapshot(doc)));

  //register student
  Future<Student> createNewStudent({
    required String userId,
    required String program,
    required String fName,
    required String lName,
    String? mName,
    required DateTime dBirth,
    required String address,
    required String contactNum,
  }) async {
    final dateBirth = DateTime(
      dBirth.year,
      dBirth.month,
      dBirth.day,
    );
    final document = await students.add({
      studentUserIdFieldName: userId,
      studentProgramFieldName: program,
      studentFNameFieldName: fName,
      studentLNameFieldName: lName,
      studentMNameFieldName: mName ?? '',
      studentDBirthFieldName: dateBirth,
      studentAddressFieldName: address,
      studentContactNumFieldName: contactNum,
      studentUnitsTakenFieldName: null,
      studentMaxUnitFieldName: null,
      assessmentsCollectionName: {
        assessmentMiscFieldName: null,
        assessmentTotalTuitionFeesFieldName: null,
      },
      createdAtFieldName: DateTime.now(),
    });

    final fetchedStudent = await document.get();
    return Student(
      userId: userId,
      studId: fetchedStudent.id,
      program: program,
      fName: fName,
      lName: lName,
      dBirth: dBirth,
      address: address,
      contactNum: contactNum,
    );
  }

  //enroll course
  Future<void> enrollStudentToCourse({
    required String userId,
    required String courseId,
    required String courseCode,
    required String courseName,
    required Map<String, dynamic> courseSchedule,
    required Map<String, dynamic>? courseScheduleLab,
  }) async {
    // Get the student document
    final student = await getStudent(ownerUserId: userId);

    final enrollmentDocs =
        await enrollments.where('student_id', isEqualTo: student.studId).get();
    final enrolledCourses = enrollmentDocs.docs.map((doc) => doc.id).toList();

    for (final enrolledCourseId in enrolledCourses) {
      final enrolledCourseDocRef = enrollments.doc(enrolledCourseId);
      final enrolledCourseDoc = await enrolledCourseDocRef.get();
      final Map<String, dynamic> enrolledCourseSchedule =
          enrolledCourseDoc.data()?['schedule'];

      // Check for conflicting schedule
      if (_hasScheduleConflict(enrolledCourseSchedule, courseSchedule)) {
        throw 'Cannot enroll in $courseId due to conflicting schedule with enrolled course $enrolledCourseId';
      }
    }

    // Add a new enrollment collection
    await enrollments.add({
      enrollmentUserIdFieldName: userId,
      enrollmentStudentIdFieldName: student.studId,
      enrollmentCourseIdFieldName: courseId,
      enrollmentCourseCodeFieldName: courseCode,
      enrollmentCourseScheduleFieldName: courseSchedule,
      enrollmentCourseScheduleLabFieldName: courseScheduleLab,
      enrollmentEnrollAtFieldName: Timestamp.now(),
      enrollmentStudentGradeFieldName: null,
    });
  }

  void unEnroll(String documentId) async {
    final enrollmentsDocRef = enrollments.doc(documentId);
    //delete course
    enrollmentsDocRef.delete();
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}
