import 'package:flutter/material.dart';

class AcademicsPage extends StatefulWidget {
  const AcademicsPage({Key? key}) : super(key: key);

  @override
  State<AcademicsPage> createState() => _AcademicsPageState();
}

class _AcademicsPageState extends State<AcademicsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Academics',
      home: DefaultTabController(
        length: 3,
        child: Scaffold(

         body: Column(
            children:  [
              const  TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.schedule,color: Colors.green,),
                      child: Text('Schedule', style: TextStyle(color: Colors.green)),),

                    Tab(icon: Icon(Icons.grade,color: Colors.green,),
                      child: Text('Grades', style: TextStyle(color: Colors.green)),),
                    Tab(icon: Icon(Icons.newspaper,color: Colors.green,),
                      child: Text('Prospectus', style: TextStyle(color: Colors.green)),),
                  ],
                ),
              Expanded(child: TabBarView(
                children: [
                  // Schedule Tab
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Section Catalog')),
                        DataColumn(label: Text('Descriptive Title')),
                        DataColumn(label: Text('Schedule / [Room] Building')),
                        DataColumn(label: Text('Teacher')),
                        DataColumn(label: Text('Google Classroom Codes')),
                        DataColumn(label: Text('Units')),
                      ],
                      rows: const [
                        DataRow(cells: [
                          DataCell(Text('GEC RIZAL [M]')),
                          DataCell(Text('Life and Works of Rizal')),
                          DataCell(Text('09:00AM-10:30AM FSat /[303 F] Freinademetz')),
                          DataCell(Text('Balabat, Restituto')),
                          DataCell(Text('lie6hib')),
                          DataCell(Text('3.0')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('CCS 106 [A]')),
                          DataCell(Text('Application Development and Emerging Technologies')),
                          DataCell(Text('12:30PM-01:30PM MW /[207-B] Bates - 01:30PM-03:00PM MW /[102C (Computer Lab)] Scanlon')),
                          DataCell(Text('Amores, Thomas Andrew')),
                          DataCell(Text('725t6b5')),
                          DataCell(Text('3.0')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('IAS 101A [A]')),
                          DataCell(Text('Information Assurance and Security 1')),
                          DataCell(Text('05:30PM-06:30PM MW /[208-B] Bates - 06:30PM-08:00PM MW /[007-1B (ComputerLab)] Bates')),
                          DataCell(Text('Fudalan, Apolinar')),
                          DataCell(Text('')),
                          DataCell(Text('3.0')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('AL 102 [A]')),
                          DataCell(Text('Automata Theory and Formal Languages')),
                          DataCell(Text('07:30AM-08:30AM MWF /[104-B] Bates')),
                          DataCell(Text('Caballo, Amie Rosarie')),
                          DataCell(Text('')),
                          DataCell(Text('3.0')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('LR 101 [A]')),
                          DataCell(Text('Logistic Regression')),
                          DataCell(Text('10:30AM-11:30AM MWF /[104-B] Bates')),
                          DataCell(Text('Lofranco, Ma Xilca')),
                          DataCell(Text('fulope4')),
                          DataCell(Text('3.0')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('IS 101A [A]')),
                          DataCell(Text('Intelligent Systems')),
                          DataCell(Text('07:30AM-09:00AM TTh /[102C (Computer Lab)] Scanlon')),
                          DataCell(Text('Navarro, Lord Francis')),
                          DataCell(Text('kkenezc')),
                          DataCell(Text('3.0')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('MATH 109 [A]')),
                          DataCell(Text('Number Theory')),
                          DataCell(Text('01:30PM-03:00PM TTh /[104-B] Bates')),
                          DataCell(Text('Arawiran, Jaremilleta')),
                          DataCell(Text('wvlrzms')),
                          DataCell(Text('3.0')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('SE 102A [A]')),
                          DataCell(Text('Software Engineering 2')),
                          DataCell(Text('05:30PM-06:30PM TTh /[104-B] Bates - 07:00PM-08:30PM TTh /[007-1B (ComputerLab)] Bates')),
                          DataCell(Text('07:00PM-08:30PM TTh /[007-1B (ComputerLab)] Bates')),
                          DataCell(Text('')),
                          DataCell(Text('3.0')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('TOTAL UNITS (Credit/Pay/Bracket):')),
                          DataCell(Text('24.00/30.00/0.00')),
                        ]),
                      ],
                    ),
                  ),
                  // Grades Tab
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Catalog Number')),
                        DataColumn(label: Text('Descriptive Title')),
                        DataColumn(label: Text('Credit Units')),
                        DataColumn(label: Text('Prelim')),
                        DataColumn(label: Text('Midterm')),
                        DataColumn(label: Text('Finals')),
                        DataColumn(label: Text('Teacher')),
                      ],
                      rows: const [
                        DataRow(cells: [
                          DataCell(Text('AL 102 (A)')),
                          DataCell(Text('Automata Theory and Formal Languages')),
                          DataCell(Text('0.0')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('CABALLO, Amie Rosarie')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('CCS 106 (A)')),
                          DataCell(Text('Application Development and Emerging Technologies')),
                          DataCell(Text('0.0')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('AMORES, Thomas Andrew')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('GEC RIZAL (M)')),
                          DataCell(Text('Life and Works of Rizal')),
                          DataCell(Text('0.0')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('BALABAT, Restituto')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('IAS 101A (A)')),
                          DataCell(Text('Information Assurance and Security 1')),
                          DataCell(Text('0.0')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('FUDALAN, Apolinar')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('IS 101A (A)')),
                          DataCell(Text('Intelligent Systems')),
                          DataCell(Text('0.0')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('NAVARRO, LORD FRANCIS')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('LR 101 (A)')),
                          DataCell(Text('Logistic Regression')),
                          DataCell(Text('0.0')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('LOFRANCO, Ma Xilca')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('MATH 109 (A)')),
                          DataCell(Text('Number Theory')),
                          DataCell(Text('0.0')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('ARAWIRAN, Jaremilleta')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('SE 102A (A)')),
                          DataCell(Text('Software Engineering 2')),
                          DataCell(Text('0.0')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('AGUNOD, Reynaldo')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('')),
                          DataCell(Text('TOTAL CREDIT UNITS')),
                          DataCell(Text('0.0')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                        ]),
                      ],
                    ),
                  ),
                  // Prospectus Tab
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Code')),
                        DataColumn(label: Text('Descriptive Title')),
                        DataColumn(label: Text('Units')),
                      ],
                      rows: const [
                        DataRow(cells: [
                          DataCell(Text('AL 102')),
                          DataCell(Text('Automata Theory and Formal Languages')),
                          DataCell(Text('3.0')),

                        ]),
                        DataRow(cells: [
                          DataCell(Text('CCS 106')),
                          DataCell(Text('Application Development and Emerging Technologies')),
                          DataCell(Text('3.0')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('CCS ELEC')),
                          DataCell(Text('Professional CS Elective')),
                          DataCell(Text('3.0')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('GEC RIZAL')),
                          DataCell(Text('Life and Works of Rizal')),
                          DataCell(Text('3.0')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('IAS 101A')),
                          DataCell(Text('Information Assurance and Security 1')),
                          DataCell(Text('3.0')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('MATH 109')),
                          DataCell(Text('Number Theory')),
                          DataCell(Text('3.0')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('PROF TRACK')),
                          DataCell(Text('Professional Track Elective')),
                          DataCell(Text('3.0')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('SE 102A')),
                          DataCell(Text('SE 102ASoftware Engineering 2')),
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
          )

      );

  }
}




