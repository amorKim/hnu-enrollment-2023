import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hnu_mis_announcement/services/auth/auth_service.dart';
import 'package:hnu_mis_announcement/services/auth/auth_user.dart';
import 'package:hnu_mis_announcement/services/cloud/firebase_cloud_storage.dart';
import 'package:hnu_mis_announcement/services/cloud/student.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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

  File? imageUrl;
  late final String? profilePic;

  @override
  void initState() {
    super.initState();
    _enrollmentService = FirebaseCloudStorage();
    userId = user!.id;
    email = user!.email;
  } //to retrieve the current authenticated user


  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      imageUrl = File(pickedFile!.path);
    });
  }

  void _showPickImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick an image'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text('Pick from gallery'),
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                GestureDetector(
                  child: const Text('Take a picture'),
                  onTap: () {
                    _pickImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String> _uploadImage() async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('students/${DateTime.now().millisecondsSinceEpoch}.jpg');

    final task = ref.putFile(imageUrl!);

    final snapshot = await task.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();

    return urlDownload.toString();
  }

  Future<void> _saveProfilePicture(Student? student) async {
    final String? documentId = student?.studId;
    final urlDownload = await _uploadImage();
    print('urlDownload: $urlDownload');
    print('studentId: $documentId');
    final studentRef = FirebaseFirestore.instance
        .collection('students')
        .doc(documentId as String);

    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot studentSnapshot = await transaction.get(studentRef);
        if (studentSnapshot.exists) {
          await studentRef.update({'imageUrl': urlDownload});
          // transaction.update(studentRef, {'imageUrl': urlDownload});
        }
      });
      print('Update successful');
    } catch (e) {
      print('Error updating image: $e');
    }
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
  } // displays different UI elements based on the state of the asynchronous snapshot.

  Widget information(Student? student) {

    final String? imgUrl = student?.imgUrl;
    final String? fName = student?.fName;
    final String? lName = student?.lName;
    final String? mName = student?.mName;
    final DateTime? dBirth = student?.dBirth;
    final String? program = student?.program;
    final String? address = student?.address;
    final String? contactNum = student?.contactNum;

    String formattedBirth = DateFormat('MM/dd/yyyy').format(dBirth!);

    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              _showPickImageDialog(context);
            },
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: Colors.green,
                  ),
                  child: ClipOval(
                    child: imageUrl != null
                        ? Image.file(
                      imageUrl!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )
                        : (imgUrl != null
                        ? Image.network(
                      imgUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )
                        : const Center(
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    )),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.camera_alt),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              _saveProfilePicture(student);
            },
            child: const Text('Update Profile Picture'),
          ),
          const SizedBox(
            width: 20,
          ),


          const SizedBox(
            height: 20,
          ),
          Text(
            'Name: $lName, $fName $mName',
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Email: $email',
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Birthdate: $formattedBirth',
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Address: $address',
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Course/Program: $program',
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Contact Number: $contactNum',
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}