import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hnu_mis_announcement/drawer/drawerItem.dart';
import 'package:hnu_mis_announcement/drawer/myinfomation.dart';
import 'package:hnu_mis_announcement/drawer/updateAddress.dart';
import 'package:hnu_mis_announcement/drawer/updateContactNum.dart';
import 'package:hnu_mis_announcement/services/auth/auth_service.dart';
import 'package:hnu_mis_announcement/services/auth/auth_user.dart';
import 'package:hnu_mis_announcement/services/cloud/firebase_cloud_storage.dart';
import 'package:hnu_mis_announcement/services/cloud/student.dart';
import 'package:hnu_mis_announcement/utilities/dialogs/logout_dialog.dart';
import 'package:hnu_mis_announcement/views/constants/route.dart';
import 'package:image_picker/image_picker.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  AuthUser? get user => AuthService.firebase().currentUser;
  late final String userId;
  late final String email;
  //late final Image imageUrl;
  late final FirebaseCloudStorage _enrollmentService;

  File? imageUrl;
  late final String? profilePic;

  @override
  void initState() {
    super.initState();
    _enrollmentService = FirebaseCloudStorage();
    userId = user!.id;
    email = user!.email;
  }

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
    return FutureBuilder(
        future: _enrollmentService.getStudent(ownerUserId: userId),
        builder: (context, student) {
          return Drawer(
            child: Material(
              color: Colors.white30,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 60, 10, 0),
                child: Column(
                  children: [
                    headerWidget(student.data),
                    const SizedBox(
                      height: 30,
                    ),
                    const Divider(
                      thickness: 1,
                      height: 15,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DrawerItems(
                      name: 'My Information',
                      icon: Icons.article_outlined,
                      onPressed: () => onItemPressed(context, index: 0),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DrawerItems(
                      name: 'Update Information',
                      icon: Icons.update,
                      onPressed: () => onItemPressed(context, index: 1),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                      height: 15,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DrawerItems(
                      name: 'Log Out',
                      icon: Icons.logout,
                      onPressed: () async {
                        final shouldLogout = await showLogOutDialog(context);
                        if (shouldLogout) {
                          await AuthService.firebase().logout();
                          if (!mounted) return;
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            loginRoute,
                            (_) => false,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);

    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MyInfo()));
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UpdateAddress()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UpdateContactNum()));
        break;
    }
  }

  Widget headerWidget(Student? student) {
    final String? fName = student?.fName;
    final String? lName = student?.lName;
    final String? mName = student?.mName;
    final String? imgUrl = student?.imgUrl;
    //const img =
    //'https://icon-library.com/images/default-profile-icon/default-profile-icon-6.jpg';
    return Column(
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
          child: const Text('Save Profile Picture'),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
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
          ],
        )
      ],
    );
  }
}
