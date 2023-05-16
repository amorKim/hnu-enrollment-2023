import 'package:flutter/material.dart';

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
    int totalLoadUnits =
        persons.map((p) => p.loadunits).reduce((a, b) => a + b);
    int totalPayUnits = persons.map((p) => p.payunits).reduce((a, b) => a + b);
    double totalAmount = persons.map((p) => p.total).reduce((a, b) => a + b);

    List<Financial> filteredPersons =
        persons.where((p) => p.payunits == 5).toList();
    double totalAssessment =
        totalAmount + filteredPersons.length * 2310.66 + 6277.25;

    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                DataTable(
                  columns: const [
                    DataColumn(label: Text('Course')),
                    DataColumn(label: Text('Load units')),
                    DataColumn(label: Text('Pay units')),
                    DataColumn(label: Text('Tuition fee')),
                  ],
                  rows: [
                    ...persons.map((person) => DataRow(cells: [
                          DataCell(Text(person.course)),
                          DataCell(Text('${person.loadunits}')),
                          DataCell(Text('${person.payunits}')),
                          DataCell(Text('₱${person.total.toStringAsFixed(2)}')),
                        ])),
                    DataRow(cells: [
                      const DataCell(Text(
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                          'Total Tuition:')),
                      DataCell(Text(totalLoadUnits.toString())),
                      DataCell(Text(totalPayUnits.toString())),
                      DataCell(Text(
                        '₱${totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      )),
                    ]),
                  ],
                ),
                const SizedBox(height: 20),
                DataTable(
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
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                      DataCell(Text(
                        '₱6277.25',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                    ]),
                  ],
                ),
                const SizedBox(height: 20),
                DataTable(
                  columns: const [
                    DataColumn(label: Text('Course')),
                    DataColumn(label: Text('Lab fee')),
                  ],
                  rows: [
                    ...filteredPersons.map((person) => DataRow(cells: [
                          DataCell(Text(person.course)),
                          const DataCell(Text("₱2310.66")),
                        ])),
                    DataRow(cells: [
                      const DataCell(Text(
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                          'Total lab fee:')),
                      DataCell(Text(
                        '₱${(filteredPersons.length * 2310.66).toStringAsFixed(2)}',
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
