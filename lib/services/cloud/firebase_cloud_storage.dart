import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hnu_mis_announcement/services/cloud/cloud_storage_constants.dart';
import 'package:hnu_mis_announcement/services/cloud/cloud_storage_exceptions.dart';
import 'package:hnu_mis_announcement/services/cloud/student.dart';

class FirebaseCloudStorage {
  final students = FirebaseFirestore.instance.collection('students');

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
    final document = await students.add({
      studentUidFieldName: userId,
      studentProgramFieldName: program,
      studentFNameFieldName: fName,
      studentLNameFieldName: lName,
      studentMNameFieldName: mName ?? '',
      studentDBirthFieldName: Timestamp.fromDate(dBirth),
      studentAddressFieldName: address,
      studentContactNumFieldName: contactNum,
      studentUnitsTakenFieldName: null,
      studentMaxUnitFieldName: null,
      assessmentsCollectionName: [
        {
          assessmentMiscFieldName: null,
          assessmentTotalTuitionFeesFieldName: null,
        }
      ],
    });
    final enrollmentCollectionRef =
        document.collection(enrollmentsCollectionName);
    await enrollmentCollectionRef.add({
      courseIdFieldName: null,
      enrollmentStudentGradeFieldName: null,
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

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}
