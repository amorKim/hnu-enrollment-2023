import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hnu_mis_announcement/services/auth/auth_service.dart';
import 'package:hnu_mis_announcement/services/cloud/firebase_cloud_storage.dart';
import 'package:hnu_mis_announcement/utilities/dialogs/error_dialog.dart';
import 'package:hnu_mis_announcement/utilities/dialogs/update_success_dialog.dart';
import 'package:intl/intl.dart';
import '../services/auth/auth_user.dart';
import '../services/cloud/student.dart';

class UpdateAddress extends StatefulWidget {
  const UpdateAddress({super.key});

  @override
  State<UpdateAddress> createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {
  bool _controllersInitialized = false;
  late final FirebaseCloudStorage _studentService;
  late final TextEditingController _firstName;
  late final TextEditingController _lastName;
  late final TextEditingController _middleName;
  late final TextEditingController _dateBirth;
  DateTime? _selectedDate;
  late final TextEditingController _address;
  late final TextEditingController _contactNumber;

  AuthUser? get user => AuthService.firebase().currentUser;
  late final String userId;
  late Future<Student?> _studentFuture;

  @override
  void initState() {
    _studentService = FirebaseCloudStorage();
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _middleName = TextEditingController();
    _address = TextEditingController();
    _contactNumber = TextEditingController();
    _dateBirth = TextEditingController();
    userId = user!.id;
    _studentFuture = _studentService.getStudent(ownerUserId: userId);
    super.initState();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _middleName.dispose();
    _address.dispose();
    _contactNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Update Student Information'),
      ),
      body: FutureBuilder<Student?>(
          future: _studentFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData && !_controllersInitialized) {
              _firstName.text = snapshot.data?.fName ?? '';
              _lastName.text = snapshot.data?.lName ?? '';
              _middleName.text = snapshot.data?.mName ?? '';
              _address.text = snapshot.data?.address ?? '';
              _selectedDate = snapshot.data?.dBirth;
              _contactNumber.text = snapshot.data?.contactNum ?? '';
              _dateBirth.text = _selectedDate != null
                  ? DateFormat('MM/dd/yyyy').format(_selectedDate!)
                  : '';

              _controllersInitialized = true;
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      controller: _firstName,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'First Name'),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      controller: _lastName,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Last Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      controller: _middleName,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Middle name',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: GestureDetector(
                      onTap: () async {
                        final initialDate = _selectedDate ?? DateTime.now();
                        final newDate = await showDatePicker(
                          context: context,
                          initialDate: initialDate,
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (newDate != null) {
                          setState(() {
                            _selectedDate = newDate;
                            _dateBirth.text = _selectedDate != null
                                ? DateFormat('MM/dd/yyyy')
                                    .format(_selectedDate!)
                                : '';
                          });
                        }
                      },
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Select birthdate',
                          ),
                          controller: _dateBirth,
                          keyboardType: TextInputType.datetime,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      controller: _address,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter address',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      controller: _contactNumber,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter contact number',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 15),
                  Container(
                    height: 45,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(100, 50)),
                      ),
                      onPressed: () async {
                        final firstname = _firstName.text;
                        final lastname = _lastName.text;
                        final middlename = _middleName.text;
                        final dateBirth = _selectedDate;
                        final address = _address.text;
                        final contactNum = _contactNumber.text;
                        try {
                          await _studentService.updateStudent(
                            userId: userId,
                            fName: firstname,
                            lName: lastname,
                            mName: middlename,
                            dBirth: dateBirth!,
                            address: address,
                            contactNum: contactNum,
                          );
                          if (context.mounted) {
                            showUpdateSuccessDialog(context);
                          }
                        } catch (e) {
                          showErrorDialog(context, e.toString());
                        }
                      },
                      child: const Text('Update'),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
