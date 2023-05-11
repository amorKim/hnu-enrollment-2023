import 'package:flutter/material.dart';

class SectionCatalog {
  final String courseCode;
  final String courseName;

  SectionCatalog({required this.courseCode, required this.courseName});
}

class Schedule {
  final String day;
  final String time;
  final String roomBuilding;

  Schedule({required this.day, required this.time, required this.roomBuilding});
}

class Teacher {
  final String name;

  Teacher({required this.name});
}

class GoogleClassroom {
  final String code;

  GoogleClassroom({required this.code});
}

class Unit {
  final String name;

  Unit({required this.name});
}

class Section {
  final SectionCatalog sectionCatalog;
  final Schedule schedule;
  final Teacher teacher;
  final GoogleClassroom googleClassroom;
  final Unit unit;

  Section({
    required this.sectionCatalog,
    required this.schedule,
    required this.teacher,
    required this.googleClassroom,
    required this.unit,
  });
}

class Grade {
  final double unitCredit;
  final double preG;
  final double midG;
  final double finalG;

  Grade({
    required this.unitCredit,
    required this.preG,
    required this.midG,
    required this.finalG,
  });
}

class AcademicsPage extends StatefulWidget {
  const AcademicsPage({Key? key}) : super(key: key);

  @override
  State<AcademicsPage> createState() => _AcademicsPageState();
}

class _AcademicsPageState extends State<AcademicsPage> {

  final List<Section> sections = [
    Section(
        sectionCatalog: SectionCatalog(courseCode: 'MATH 109', courseName: 'MATH 109'),
        schedule: Schedule(day: 'TTh', time: '01:30PM-03:00PM', roomBuilding: '[104-B] Bates'),
        teacher: Teacher(name: 'Arawiran, Jaremilleta'),
        googleClassroom: GoogleClassroom(code: 'wvlrzms'),
        unit: Unit(name: '3.0')),
    Section(
        sectionCatalog: SectionCatalog(courseCode: 'CCS 106', courseName: 'Application Development and Emerging Technologies'),
        schedule: Schedule(day: 'TTh', time: '12:30PM-01:30PM\n01:30PM-03:00PM', roomBuilding: '[207-B] Bates\n[102C (Computer Lab)] Scanlon'),
        teacher: Teacher(name: 'Amores, Thomas Andrew'),
        googleClassroom: GoogleClassroom(code: '725t6b5'),
        unit: Unit(name: '3.0')),
    Section(
        sectionCatalog: SectionCatalog(courseCode: 'SE', courseName: 'Software Engineering 2'),
        schedule: Schedule(day: 'FSat', time: '05:30PM-06:30PM\n07:00PM-08:30PM', roomBuilding: '/[104-B] Bates\n[007-1B (ComputerLab)] Bates'),
        teacher: Teacher(name: 'Agunod, Reynaldo'),
        googleClassroom: GoogleClassroom(code: ''),
        unit: Unit(name: '3.0'))
  ];

  final List<Grade> grades = [
    Grade(unitCredit: 0.0, preG: 0.0, midG: 0.0, finalG: 0.0),
    Grade(unitCredit: 0.0, preG: 0.0, midG: 0.0, finalG: 0.0),
    Grade(unitCredit: 0.0, preG: 0.0, midG: 0.0, finalG: 0.0),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Academics',
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
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Course Code')),
                          DataColumn(label: Text('Course Name')),
                          DataColumn(label: Text('Day')),
                          DataColumn(label: Text('Time')),
                          DataColumn(label: Text('Room / Building')),
                          DataColumn(label: Text('Teacher')),
                          DataColumn(label: Text('Google Classroom Code')),
                          DataColumn(label: Text('Unit')),
                        ],
                        rows: [
                          ...sections.map((section) => DataRow(cells: [
                            DataCell(Text(section.sectionCatalog.courseCode)),
                            DataCell(Text(section.sectionCatalog.courseName)),
                            DataCell(Text(section.schedule.day)),
                            DataCell(Text(section.schedule.time)),
                            DataCell(Text(section.schedule.roomBuilding)),
                            DataCell(Text(section.teacher.name)),
                            DataCell(Text(section.googleClassroom.code)),
                            DataCell(Text(section.unit.name)),
                          ]))
                        ],
                      ),
                    ),

                    // Grades Tab
                    SingleChildScrollView(
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Credit Unit')),
                          DataColumn(label: Text('Pre')),
                          DataColumn(label: Text('Mid')),
                          DataColumn(label: Text('Final')),
                        ],
                        rows: [
                          ...grades.map((grades) => DataRow(
                              cells: [
                                DataCell(Text('${grades.unitCredit}')),
                                DataCell(Text('${grades.preG}')),
                                DataCell(Text('${grades.midG}')),
                                DataCell(Text('${grades.finalG}')),
                              ]),
                          ),
                        ],
                      ),
                    ),

                    // Prospectus Tab
                    SingleChildScrollView(
                      child: DataTable(
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