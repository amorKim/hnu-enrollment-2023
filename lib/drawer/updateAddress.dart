import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/auth/auth_service.dart';
import '../services/auth/auth_user.dart';
import '../services/cloud/firebase_cloud_storage.dart';
import '../services/cloud/student.dart';

class UpdateAddress extends StatefulWidget {
  const UpdateAddress({Key? key}) : super(key: key);

  @override
  UpdateAddressState createState() => UpdateAddressState();
}

class UpdateAddressState extends State<UpdateAddress> {
  AuthUser? get user => AuthService.firebase().currentUser;
  late final String userId;
  late final String email;

  late final TextEditingController _address;

  late final FirebaseCloudStorage _enrollmentService;


  @override
  void initState() {
    super.initState();
    _enrollmentService = FirebaseCloudStorage();
    _address = TextEditingController();
    userId = user!.id;
    email = user!.email;
  }

  @override
  void dispose() {
    _address.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Address"),
        centerTitle: true,
      ),
      body: FutureBuilder<Student?>(
        future: _enrollmentService.getStudent(ownerUserId: userId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return udAddress(snapshot.data);
          } else if (snapshot.hasError) {
            return const Text("Error Fetching Data");
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget udAddress(Student? student) {
    final String? fName = student?.fName;
    final String? lName = student?.lName;
    final String? mName = student?.mName;

    return Column(
      children: [
        Center(
          child: Container(
            child: Text(
              '$lName, $fName $mName',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              controller: _address,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Address',
              ),
            ),
          ),
        ),



      ],
    );
  }

} //to display the student's address information and an input field for updating the address.