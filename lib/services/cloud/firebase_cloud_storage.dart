import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hnu_mis_announcement/services/cloud/cloud_storage_constants.dart';
import 'package:hnu_mis_announcement/services/cloud/cloud_storage_exceptions.dart';
import 'package:hnu_mis_announcement/services/cloud/course.dart';
import 'package:hnu_mis_announcement/services/cloud/enrollment.dart';
import 'package:hnu_mis_announcement/services/cloud/student.dart';

class FirebaseCloudStorage {
  final students = FirebaseFirestore.instance.collection('students');
  final courses = FirebaseFirestore.instance.collection('courses');

  //get all course offered
  Stream<Iterable<Course>> allCourses() => courses
      .snapshots()
      .map((event) => event.docs.map((doc) => Course.fromSnapshot(doc)));

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

  Future<void> enrollStudentToCourse({
    required String studentId,
    required String courseId,
  }) async {
    // Get the student and course documents
    final studentDocRef = students.doc(studentId);
    final courseDocRef = courses.doc(courseId);

    // Add a new enrollment sub-collection to the student document
    final enrollmentDocRef = await studentDocRef.collection('enrollments').add({
      enrollmentCourseIdFieldName: courseId,
      enrollmentEnrollAtFieldName: Timestamp.now(),
      enrollmentStudentGradeFieldName: null,
    });

    // Add a new enrollment sub-map to the course document
    final enrollmentId = await enrollmentDocRef.get();
    final enrollmentData = {
      'enrollmentId': enrollmentId,
      'studentId': studentId,
      'studentGrade': null,
    };
    await courseDocRef.update({
      'enrollments': FieldValue.arrayUnion([enrollmentData]),
    });
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}
