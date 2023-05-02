import 'package:flutter/material.dart';
import 'package:hnu_mis_announcement/views/enrollmentPage/enrollment_view.dart';
import 'package:hnu_mis_announcement/views/homepage/announcement.dart';

import '../enrollmentPage/courses_list_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: const [
            TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.app_registration,
                    color: Colors.green,
                  ),
                  child:
                      Text('Enrollment', style: TextStyle(color: Colors.green)),
                ),
                Tab(
                  icon: Icon(
                    Icons.newspaper,
                    color: Colors.green,
                  ),
                  child: Text('Announcement',
                      style: TextStyle(color: Colors.green)),
                )
              ],
            ),
            Expanded(
              child: TabBarView(children: [
                //enrollment tab
                EnrollmentView(),
                //announcement page
                AnnouncementPage()
              ]),
            )
          ],
        ),
      ),
    );
  }
}
