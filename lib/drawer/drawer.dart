import 'package:flutter/material.dart';
import 'package:hnu_mis_announcement/drawer/drawerItem.dart';
import 'package:hnu_mis_announcement/drawer/myinfomation.dart';
import 'package:hnu_mis_announcement/drawer/updateAddress.dart';
import 'package:hnu_mis_announcement/drawer/updateContactNum.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

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
              const SizedBox(height: 30,),
              const Divider(thickness: 1, height: 15, color: Colors.grey,),
              const SizedBox(height: 15,),
              DrawerItems(
                  name: 'My Information',
                  icon: Icons.article_outlined,
                onPressed: ()=> onItemPressed(context, index: 0),
              ),
              const SizedBox(height: 10,),
              DrawerItems(
                name: 'Update Address',
                icon: Icons.location_city,
                onPressed: ()=> onItemPressed(context, index: 1),
              ),
              const SizedBox(height: 10,),
              DrawerItems(
                name: 'Update Contact Number',
                icon: Icons.contact_phone_outlined,
                onPressed: ()=> onItemPressed(context, index: 2),
              ),
              const SizedBox(height: 20,),
              const Divider(thickness: 1, height: 15, color: Colors.grey,),
              const SizedBox(height: 15,),
              DrawerItems(
                name: 'Log Out',
                icon: Icons.logout,
                onPressed: ()=> onItemPressed(context, index: 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void onItemPressed(BuildContext context, {required int index}){
    Navigator.pop(context);

    switch(index){
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const My_Info()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateAddress()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateContactNum()));
        break;
    }
  }
  Widget headerWidget(){
    const img = 'assets/Kimberly Amor.jpg';
    return Column(

      children:  [
        const CircleAvatar(
          radius: 40,
            backgroundImage: AssetImage(img),
        ),
        const SizedBox(width: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(height: 10,),

            Text('Kimberly Amor', style: TextStyle(fontSize: 16, color: Colors.black),),
            SizedBox(height: 10,),
            Text('amor.kimberly@hnu.edu.ph', style: TextStyle(fontSize: 16, color: Colors.black),),
            SizedBox(height: 10,),
            Text('Roman Catholic', style: TextStyle(fontSize: 16, color: Colors.black),)
          ],
        )
      ],
    );
  }
}
