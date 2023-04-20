import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hnu_mis_announcement/services/cloud/cloud_storage_constants.dart';
import 'package:hnu_mis_announcement/services/cloud/cloud_storage_exceptions.dart';
import 'package:hnu_mis_announcement/services/cloud/student.dart';

class FirebaseCloudStorage {
  final students = FirebaseFirestore.instance.collection('students');

  // Future<void> deleteNote({required String documentId}) async {
  //   try {
  //     await notes.doc(documentId).delete();
  //   } catch (e) {
  //     throw CouldNotDeleteNoteException();
  //   }
  // }

  // Future<void> updateNote({
  //   required String documentId,
  //   required String text,
  // }) async {
  //   try {
  //     await notes.doc(documentId).update({textFieldName: text});
  //   } catch (e) {
  //     throw CouldNotUpdateNoteException();
  //   }
  // }

  // Stream<Iterable<CloudNote>> allNotes({required String ownerUserId}) =>
  //     notes.snapshots().map((event) => event.docs
  //         .map((doc) => CloudNote.fromSnapshot(doc))
  //         .where((note) => note.ownerUserId == ownerUserId));

  // Future<Iterable<CloudNote>> getNote({required String ownerUserId}) async {
  //   try {
  //     return await notes
  //         .where(
  //           ownerUserIdFieldName,
  //           isEqualTo: ownerUserId,
  //         )
  //         .get()
  //         .then(
  //           (value) => value.docs.map((doc) => CloudNote.fromSnapshot(doc)),
  //         );
  //   } catch (e) {
  //     throw CouldNotUpdateNoteException();
  //   }
  // }

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
      studentEnrollmentsFieldName: null,
      studentAssessmentsFieldName: null,
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
