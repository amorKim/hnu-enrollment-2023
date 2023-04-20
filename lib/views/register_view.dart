import 'package:flutter/material.dart';
import 'package:hnu_mis_announcement/services/auth/auth_exceptions.dart';
import 'package:hnu_mis_announcement/services/auth/auth_service.dart';
import 'package:hnu_mis_announcement/services/cloud/firebase_cloud_storage.dart';
import 'package:hnu_mis_announcement/services/cloud/student.dart';
import 'package:hnu_mis_announcement/utilities/dialogs/error_dialog.dart';
import 'package:hnu_mis_announcement/views/constants/route.dart';
import 'package:intl/intl.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final FirebaseCloudStorage _studentService;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _firstName;
  late final TextEditingController _lastName;
  late final TextEditingController _middleName;
  late final TextEditingController _program;
  DateTime? _selectedDate;
  late final TextEditingController _address;
  late final TextEditingController _contactNumber;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _middleName = TextEditingController();
    _program = TextEditingController();
    _address = TextEditingController();
    _contactNumber = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _middleName.dispose();
    _program.dispose();
    _address.dispose();
    _contactNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Student'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: 'Enter your email'),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration:
                  const InputDecoration(hintText: 'Enter your password'),
            ),
            TextField(
              controller: _program,
              enableSuggestions: false,
              autocorrect: false,
              decoration:
                  const InputDecoration(hintText: 'Enter your program/course'),
            ),
            TextField(
              controller: _firstName,
              enableSuggestions: false,
              autocorrect: false,
              decoration:
                  const InputDecoration(hintText: 'Enter your first name'),
            ),
            TextField(
              controller: _lastName,
              enableSuggestions: false,
              autocorrect: false,
              decoration:
                  const InputDecoration(hintText: 'Enter your last name'),
            ),
            TextField(
              controller: _middleName,
              enableSuggestions: false,
              autocorrect: false,
              decoration:
                  const InputDecoration(hintText: 'Enter your middle name'),
            ),
            GestureDetector(
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
                  });
                }
              },
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Select your date of birth',
                  ),
                  controller: TextEditingController(
                    text: _selectedDate != null
                        ? DateFormat('MM/dd/yyyy').format(_selectedDate!)
                        : '',
                  ),
                  keyboardType: TextInputType.datetime,
                  textInputAction: TextInputAction.done,
                ),
              ),
            ),
            TextField(
              controller: _address,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(hintText: 'Enter your address'),
            ),
            TextField(
              controller: _contactNumber,
              enableSuggestions: false,
              autocorrect: false,
              decoration:
                  const InputDecoration(hintText: 'Enter your contact number'),
            ),
            TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                final program = _program.text;
                final firstname = _firstName.text;
                final lastname = _lastName.text;
                final middlename = _middleName.text;
                final dateBirth = _selectedDate;
                final address = _address.text;
                final contactNum = _contactNumber.text;
                try {
                  // Create user account
                  await AuthService.firebase().createUser(
                    email: email,
                    password: password,
                  );

                  String userId = AuthService.firebase().currentUser!.id;

                  await _studentService.createNewStudent(
                    userId: userId,
                    program: program,
                    fName: firstname,
                    lName: lastname,
                    dBirth: dateBirth!,
                    address: address,
                    contactNum: contactNum,
                  );

                  // Register student account
                  // final student = Student(
                  //     userId: userId,
                  //     studId: studId,
                  //     program: program,
                  //     fName: fName,
                  //     lName: lName,
                  //     mName: ,
                  //     dBirth: dBirth,
                  //     address: address,
                  //     contactNum: contactNum);

                  // final student = Student(
                  //   userId: user.uid,
                  //   program: _program.text,
                  //   firstName: _firstName.text,
                  //   lastName: _lastName.text,
                  //   middleName: _middleName.text,
                  //   dateOfBirth: _dateOfBirth.text,
                  //   email: _email.text,
                  //   address: _address.text,
                  //   contactNumber: _contactNumber.text,
                  //   unitsTaken: int.tryParse(_unitsTaken.text) ?? null,
                  //   maxUnit: int.tryParse(_maxUnit.text) ?? null,
                  //   enrollments: [],
                  //   assessment: Assessment(
                  //     misc: int.tryParse(_misc.text) ?? null,
                  //     totalTuitionFees: int.tryParse(_totalTuitionFees.text) ?? null,
                  //   ),
                  // );
                  // await StudentService().createStudent(student);

                  // Send email verification
                  AuthService.firebase().sendEmailVerification();

                  if (!mounted) return;
                  Navigator.of(context).pushNamed(verifyEmailRoute);
                } on WeakPasswordAuthException {
                  await showErrorDialog(
                    context,
                    'Weak password',
                  );
                } on EmailAlreadyInUseAuthException {
                  await showErrorDialog(
                    context,
                    'Email is already in use',
                  );
                } on InvalidEmailAuthException {
                  await showErrorDialog(
                    context,
                    'This is an invalid email address',
                  );
                } on GenericAuthException {
                  await showErrorDialog(
                    context,
                    'Failed to register',
                  );
                } catch (e) {
                  print(e);
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
