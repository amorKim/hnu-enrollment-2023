import 'package:flutter/material.dart';

class EnrollmentPage extends StatefulWidget {
  const EnrollmentPage({Key? key}) : super(key: key);

  @override
  State<EnrollmentPage> createState() => _EnrollmentPageState();
}

class _EnrollmentPageState extends State<EnrollmentPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
    child: Text('Enroll Here'),
    );
  }
}
