import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../main.dart';


class FinancialsPage extends StatefulWidget {
  const FinancialsPage({Key? key}) : super(key: key);


  @override
  State<FinancialsPage> createState() => _FinancialsPageState();
}

class _FinancialsPageState extends State<FinancialsPage> {
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

  @override
  Widget build(BuildContext context) {
    int totalLoadUnits = persons.map((p) => p.loadunits).reduce((a, b) => a + b);
    int totalPayUnits = persons.map((p) => p.payunits).reduce((a, b) => a + b);
    double totalAmount = persons.map((p) => p.total).reduce((a, b) => a + b);


    List<Financial> filteredPersons =
    persons.where((p) => p.payunits == 5).toList();
    double totalAssessment = totalAmount + filteredPersons.length * 2310.66 + 6277.25;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FINANCIAL',
      home: Scaffold(
        body: SingleChildScrollView(
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
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),'Total Tuition:')),
                    DataCell(Text(totalLoadUnits.toString())),
                    DataCell(Text(totalPayUnits.toString())),
                    DataCell(Text('₱${totalAmount.toStringAsFixed(2)}',style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    )),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text(
                      'TOTAL ASSESSMENT:',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                    const DataCell(Text('')),
                    const DataCell(Text('')),
                    DataCell(Text('₱${totalAssessment.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                  ]),

                ],
              ),const SizedBox(height: 20),
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
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                        'Total lab fee:')),
                    DataCell(Text(
                      '₱${(filteredPersons.length * 2310.66).toStringAsFixed(2)}',style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    )),
                  ]),

                ],
              ),const SizedBox(height: 20),
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
                    DataCell(Text('Community Extension Services/Corporate Social Responsibility (CES/CSR)')),
                    DataCell(Text('₱59.40')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('PRISAA')),
                    DataCell(Text('₱100.00')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('DevelopmenPublication Fee (The Word)')),
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
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Total Amount: ₱6277.25',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





