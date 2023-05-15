import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/auth/auth_service.dart';
import '../services/auth/auth_user.dart';
import '../services/cloud/firebase_cloud_storage.dart';
import '../services/cloud/student.dart';

class MyInfo extends StatefulWidget {
  const MyInfo({Key? key}) : super(key: key);

  @override
  MyInfoState createState() => MyInfoState();
}

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
  }

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
  }

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