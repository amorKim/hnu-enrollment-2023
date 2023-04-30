import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hnu_mis_announcement/drawer/drawerItem.dart';
import 'package:hnu_mis_announcement/drawer/myinfomation.dart';
import 'package:hnu_mis_announcement/drawer/updateAddress.dart';
import 'package:hnu_mis_announcement/drawer/updateContactNum.dart';
import 'package:hnu_mis_announcement/services/auth/auth_service.dart';
import 'package:hnu_mis_announcement/utilities/dialogs/logout_dialog.dart';
import 'package:hnu_mis_announcement/views/constants/route.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

////
final FirebaseAuth _auth = FirebaseAuth.instance;
final User? user = _auth.currentUser;
////

class _MyDrawerState extends State<MyDrawer> {
  String? firstName;

  Future<void> getUserFirstName() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final documentSnapshot = await FirebaseFirestore.instance.collection('students').doc(currentUser!.uid).get();

    setState(() {
      firstName = documentSnapshot.data()?['f_name'];
    });
  }

  @override
  void initState() {
    super.initState();
    getUserFirstName();
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.white30,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 60, 10, 0),
          child: Column(
            children: [
              headerWidget(),
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
                name: 'Update Address',
                icon: Icons.location_city,
                onPressed: () => onItemPressed(context, index: 1),
              ),
              const SizedBox(
                height: 10,
              ),
              DrawerItems(
                name: 'Update Contact Number',
                icon: Icons.contact_phone_outlined,
                onPressed: () => onItemPressed(context, index: 2),
              ),
              const SizedBox(
                height: 20,
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
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);

    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const My_Info()));
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

  Widget headerWidget() {
    const img = 'assets/Kimberly Amor.jpg';
    return Column(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage(img),
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
              firstName != null ? '$firstName' : 'Loading',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(user?.email ?? 'No user logged in'),
          ],
        )
      ],
    );
  }
}