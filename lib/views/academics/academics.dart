import 'package:flutter/material.dart';
import 'package:hnu_mis_announcement/services/auth/auth_service.dart';
import 'package:hnu_mis_announcement/services/cloud/firebase_cloud_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hnu_mis_announcement/services/cloud/cloud_storage_constants.dart';

class AcademicsPage extends StatefulWidget {
  String get userId => AuthService.firebase().currentUser!.id;

  const AcademicsPage({Key? key}) : super(key: key);

  @override
  _AcademicsPageState createState() => _AcademicsPageState();
}

class _AcademicsPageState extends State<AcademicsPage> {
  final FirebaseCloudStorage enrollmentService = FirebaseCloudStorage();

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.schedule,
                      color: Colors.green,
                    ),
                    child: Text(
                      'Schedule',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.grade,
                      color: Colors.green,
                    ),
                    child: Text(
                      'Grades',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.newspaper,
                      color: Colors.green,
                    ),
                    child: Text(
                      'Prospectus',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // Schedule Tab
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          StreamBuilder(
                            stream: enrollmentService.allEnrollmentsOfStudent(userId: widget.userId),
                            builder: (context, enrollments) {
                              if (!enrollments.hasData || enrollments.data!.isEmpty) {
                                return const Text(
                                  'No Enrollments yet',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                );
                              }
                              // Handle the case when data is available
                              return DataTable(
                                dataRowHeight: deviceHeight * 0.1,
                                headingRowHeight: deviceHeight * 0.1,
                                columnSpacing: deviceWidth * 0.12,
                                columns: const [
                                  DataColumn(label: Text('Course Code')),
                                  DataColumn(label: Text('Day')),
                                  DataColumn(label: Text('Time')),
                                  DataColumn(label: Text('Room / Building')),
                                  DataColumn(label: Text('Teacher')),
                                  DataColumn(label: Text('Unit')),
                                ],
                                rows: [
                                  ...?enrollments.data?.map((enrollment) {
                                    return DataRow(cells: [
                                      DataCell(Center(child: Text(enrollment.courseCode))),
                                      DataCell(Center(child: Text(enrollment.))),
                                      DataCell(Center(child: Text(enrollment.schedule))),
                                      DataCell(Center(child: Text(enrollment.scheduleLab))),
                                      DataCell(Center(child: Text(enrollment.))),
                                    ]);
                                  }),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    // Grades Tab
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          StreamBuilder(
                            stream: enrollmentService.allEnrollmentsOfStudent(userId: widget.userId),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return const Text(
                                  'No Enrollments yet',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                );
                              }
                              // Handle the case when data is available
                              return Container(); // Placeholder widget, replace with your desired content
                            },
                          ),
                        ],
                      ),
                    ),
                    // Prospectus Tab
                    Container(
                      child: Center(
                        child: Text('Prospectus Tab Content'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
