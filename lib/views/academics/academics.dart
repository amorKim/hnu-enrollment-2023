import 'package:flutter/material.dart';
import 'package:hnu_mis_announcement/services/auth/auth_service.dart';
import 'package:hnu_mis_announcement/services/cloud/firebase_cloud_storage.dart';

class AcademicsPage extends StatefulWidget {
  String get userId => AuthService.firebase().currentUser!.id;

  const AcademicsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AcademicsPageState createState() => _AcademicsPageState();
}

class _AcademicsPageState extends State<AcademicsPage> {
  final FirebaseCloudStorage enrollmentService = FirebaseCloudStorage();

  late double totalGrade;
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
              const TabBar(
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
                                dataRowHeight: deviceHeight * 0.09,
                                headingRowHeight: deviceHeight * 0.08,
                                columnSpacing: deviceWidth * 0.02,
                                columns: const [
                                  DataColumn(label: Text('Course \nName')),
                                  DataColumn(label: Text('Day')),
                                  DataColumn(label: Text('Room')),
                                  DataColumn(label: Text('Time')),
                                ],
                                rows: [
                                  ...?enrollments.data?.map((enrollment) => DataRow(cells: [
                                    DataCell(Text(enrollment.courseCode)),
                                    DataCell(Text(enrollment.schedule['days'])),
                                    DataCell(Text(enrollment.schedule['room'])),
                                    DataCell(Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(enrollment.schedule['start_time']),
                                        Text(enrollment.schedule['end_time']),
                                      ],
                                    ),
                                    ),
                                  ])),
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
                            builder: (context, enrollments) {
                              if (!enrollments.hasData || enrollments.data!.isEmpty) {
                                return const Text(
                                  'No Enrollments yet',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                );
                              } else {
                                totalGrade = enrollments.data!.toList().length * 2310.66;
                                // Handle the case when data is available
                                return DataTable(
                                  dataRowHeight: deviceHeight * 0.09,
                                  headingRowHeight: deviceHeight * 0.08,
                                  columnSpacing: deviceWidth * 0.1,
                                  columns: const [
                                    DataColumn(label: Text('Credit Units')),
                                    DataColumn(label: Text('Prelim')),
                                    DataColumn(label: Text('Midterm')),
                                    DataColumn(label: Text('Final')),
                                  ],
                                  rows: [
                                    ...?enrollments.data?.map((enrollment) => DataRow(
                                      cells: [
                                        DataCell(Text(enrollment.studGrade ?? '0.0')),
                                        DataCell(Text(enrollment.studGrade ?? '0.0')),
                                        DataCell(Text(enrollment.studGrade ?? '0.0')),
                                        DataCell(Text(enrollment.studGrade ?? '0.0')),
                                      ],
                                    )),
                                  ],
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    // Prospectus Tab
                    SingleChildScrollView(
                      child: DataTable(
                        dataRowHeight: deviceHeight * 0.09,
                        headingRowHeight: deviceHeight * 0.08,
                        columnSpacing: deviceWidth * 0.1,
                        columns: const [
                          DataColumn(label: Text('Code')),
                          DataColumn(label: Text('Descriptive Title')),
                          DataColumn(label: Text('Units')),
                        ],
                        rows: const [
                          DataRow(cells: [
                            DataCell(Text('AL 102')),
                            DataCell(Text('Automata Theory \nand Formal \nLanguages')),
                            DataCell(Text('3.0')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('CCS 106')),
                            DataCell(Text('Application \nDevelopment \nand Emerging \nTechnologies')),
                            DataCell(Text('3.0')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('CCS ELEC')),
                            DataCell(Text('Professional \nCS \nElective')),
                            DataCell(Text('3.0')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('GEC RIZAL')),
                            DataCell(Text('Life and \nWorks of \nRizal')),
                            DataCell(Text('3.0')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('IAS 101A')),
                            DataCell(Text('Information \nAssurance \nand Security 1')),
                            DataCell(Text('3.0')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('MATH 109')),
                            DataCell(Text('Number Theory')),
                            DataCell(Text('3.0')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('PROF TRACK')),
                            DataCell(Text('Professional \nTrack \nElective')),
                            DataCell(Text('3.0')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('SE 102A')),
                            DataCell(Text('SE 102ASoftware \nEngineering 2')),
                            DataCell(Text('3.0')),
                          ]),
                        ],
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