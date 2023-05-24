import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //internationalization and localization support for formatting dates, numbers, currencies, and messages.

import '../services/auth/auth_service.dart'; //to use the authentication service
import '../services/auth/auth_user.dart'; //to access the authentication user class or functionality
import '../services/cloud/firebase_cloud_storage.dart'; //to utilize the functionality related to Firebase Cloud Storage
import '../services/cloud/student.dart'; //to utilize the functionality or data related to the "student"

class MyInfo extends StatefulWidget {
  const MyInfo({Key? key}) : super(key: key);

  @override
  MyInfoState createState() => MyInfoState();
} //providing the implementation for creating and managing the state of the widget.

class MyInfoState extends State<MyInfo> {
  AuthUser? get user => AuthService.firebase().currentUser;
  late final String userId;
  late final String email;

  late final FirebaseCloudStorage _enrollmentService;

  @override
  void initState() {
    super.initState();
    _enrollmentService = FirebaseCloudStorage();
    userId = user!.id;
    email = user!.email;
  } //to retrieve the current authenticated user

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Information"),
        centerTitle: true,
      ),
      body: FutureBuilder<Student?>(
        future: _enrollmentService.getStudent(ownerUserId: userId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return information(snapshot.data);
          } else if (snapshot.hasError) {
            return const Text("Error Fetching Data");
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  } // displays different UI elements based on the state of the asynchronous snapshot.

  Widget information(Student? student) {
    final String? fName = student?.fName;
    final String? lName = student?.lName;
    final String? mName = student?.mName;
    final DateTime? dBirth = student?.dBirth;
    final String? program = student?.program;
    final String? address = student?.address;
    final String? contactNum = student?.contactNum;

    String formattedBirth = DateFormat('mm/dd/yyyy').format(dBirth!);

    return Column(
      children: [
        Text(
          '$lName, $fName $mName',
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          email,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          formattedBirth,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          '$address',
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          '$program',
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          '$contactNum',
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }
}
