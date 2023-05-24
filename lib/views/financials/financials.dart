import 'package:flutter/material.dart';
import 'package:hnu_mis_announcement/services/auth/auth_service.dart';
import 'package:hnu_mis_announcement/services/cloud/firebase_cloud_storage.dart';

class Financial {
  final String course;
  final int loadunits;
  final int payunits;
  double get total => payunits * 752.0;

  Financial({
    required this.course,
    required this.loadunits,
    required this.payunits,
  });
}

class FinancialsPage extends StatelessWidget {
  String get userId => AuthService.firebase().currentUser!.id;
  final List<Financial> persons = [
    Financial(course: 'CCS 106', loadunits: 3, payunits: 5),
    Financial(course: 'IAS 101A', loadunits: 3, payunits: 5),
    Financial(course: 'IS 101A', loadunits: 3, payunits: 3),
    Financial(course: 'SE 102A', loadunits: 3, payunits: 5),
    Financial(course: 'AL 102', loadunits: 3, payunits: 3),
    Financial(course: 'LR 101', loadunits: 3, payunits: 3),
    Financial(course: 'MATH 109', loadunits: 3, payunits: 3),
    Financial(course: 'GEC RIZAL', loadunits: 3, payunits: 3),
  ];

  FinancialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    final FirebaseCloudStorage enrollmentService = FirebaseCloudStorage();
    const int tuitionFee = 752;

    double totalTuition = 0;
    double totalLabFee;
    double totalAssessment;
    {}
    return SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder(
              stream: enrollmentService.allEnrollmentsOfStudent(userId: userId),
              builder: (context, enrollments) {
                if (!enrollments.hasData || enrollments.data!.isEmpty) {
                  return const Text(
                    'No Enrollments yet',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  );
                }

                totalTuition = enrollments.data!
                    .map((enrollment) => enrollment.payUnit * tuitionFee)
                    .reduce((a, b) => a + b)
                    .toDouble();
                return DataTable(
                  dataRowHeight: deviceHeight * 0.1,
                  headingRowHeight: deviceHeight * 0.1,
                  columnSpacing: deviceWidth * 0.12,
                  columns: const [
                    DataColumn(label: Text('Course')),
                    DataColumn(label: Text('Pay units')),
                    DataColumn(label: Text('Tuition fee')),
                  ],
                  rows: [
                    ...?enrollments.data?.map((enrollment) {
                      int subTuition = enrollment.payUnit * tuitionFee;
                      return DataRow(cells: [
                        DataCell(Text(enrollment.courseCode)),
                        DataCell(Center(child: Text('${enrollment.payUnit}'))),
                        DataCell(Center(child: Text('₱$subTuition')))
                      ]);
                    }),
                    DataRow(cells: [
                      const DataCell(Text(
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                          'Total Tuition:')),
                      DataCell(Center(
                        child: Text(
                            '${enrollments.data?.map((enrollment) => enrollment.payUnit).reduce((a, b) => a + b)}'),
                      )),
                      DataCell(Center(
                        child: Text(
                          '₱$totalTuition',
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      )),
                    ]),
                  ],
                );
              }),
          const SizedBox(height: 20),
          DataTable(
            dataRowHeight: deviceHeight * 0.1,
            headingRowHeight: deviceHeight * 0.1,
            columnSpacing: deviceWidth * 0.05,
            columns: const [
              DataColumn(label: Text('Miscellaneous and Other Fees')),
              DataColumn(label: Text('Amount')),
            ],
            rows: const [
              DataRow(cells: [
                DataCell(Text('Matriculation Fee')),
                DataCell(Text('₱632.02')),
              ]),
              DataRow(cells: [
                DataCell(Text('Athletic')),
                DataCell(Text('₱264.92')),
              ]),
              DataRow(cells: [
                DataCell(Text('Dental')),
                DataCell(Text('₱112.86')),
              ]),
              DataRow(cells: [
                DataCell(Text('Guidance & Counseling')),
                DataCell(Text('₱281.56')),
              ]),
              DataRow(cells: [
                DataCell(Text('Medical')),
                DataCell(Text('₱112.86')),
              ]),
              DataRow(cells: [
                DataCell(Text('Performing Arts Fee')),
                DataCell(Text('₱150.88')),
              ]),
              DataRow(cells: [
                DataCell(Text('Community Extension Services')),
                DataCell(Text('₱59.40')),
              ]),
              DataRow(cells: [
                DataCell(Text('PRISAA')),
                DataCell(Text('₱100.00')),
              ]),
              DataRow(cells: [
                DataCell(Text('Development Publication Fee (The Word)')),
                DataCell(Text('₱100.00')),
              ]),
              DataRow(cells: [
                DataCell(Text('  Student Government')),
                DataCell(Text('₱150.00')),
              ]),
              DataRow(cells: [
                DataCell(Text('Student Insurance')),
                DataCell(Text('₱50.00')),
              ]),
              DataRow(cells: [
                DataCell(Text('Learning Resources Fee')),
                DataCell(Text('₱2697.95')),
              ]),
              DataRow(cells: [
                DataCell(Text('Student Support Services')),
                DataCell(Text('₱1564.80')),
              ]),
              DataRow(cells: [
                DataCell(Text(
                  'Total Amount:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )),
                DataCell(Text(
                  '₱6277.25',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )),
              ]),
            ],
          ),
          const SizedBox(height: 10),
          StreamBuilder(
              stream: enrollmentService.allEnrollmentsOfStudentWithLab(
                  userId: userId),
              builder: (context, enrollments) {
                if (!enrollments.hasData || enrollments.data!.isEmpty) {
                  totalAssessment = totalTuition + 6277.25;
                  return Column(
                    children: [
                      const Text(
                        'No enrolled courses with Lab',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'TOTAL ASSESSMENT:',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12),
                            child: Text(
                              '₱${totalAssessment.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  totalLabFee = enrollments.data!.toList().length * 2310.66;
                  totalAssessment = totalTuition + totalLabFee + 6277.25;
                  return DataTable(
                    columns: const [
                      DataColumn(label: Text('Course')),
                      DataColumn(label: Text('Lab fee')),
                    ],
                    rows: [
                      ...?enrollments.data?.map((enrollment) => DataRow(cells: [
                            DataCell(Text(enrollment.courseCode)),
                            const DataCell(Text("₱2310.66")),
                          ])),
                      DataRow(cells: [
                        const DataCell(Text(
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                            'Total lab fee:')),
                        DataCell(Text(
                          '₱${totalLabFee.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        )),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text(
                          'TOTAL ASSESSMENT:',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )),
                        DataCell(
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12),
                            child: Text(
                              '₱${totalAssessment.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ]),
                    ],
                  );
                }
              }),
        ],
      ),
    );
  }
}
