import 'package:flutter/material.dart';
import 'package:hnu_mis_announcement/services/auth/auth_exceptions.dart';
import 'package:hnu_mis_announcement/services/auth/auth_service.dart';
import 'package:hnu_mis_announcement/services/cloud/firebase_cloud_storage.dart';
import 'package:hnu_mis_announcement/services/cloud/student.dart';
import 'package:hnu_mis_announcement/utilities/dialogs/error_dialog.dart';
import 'package:hnu_mis_announcement/views/constants/route.dart';
import 'package:intl/intl.dart';
import 'package:select_form_field/select_form_field.dart';

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

  final List<Map<String, dynamic>> _programOptions = [
    {'value': 'BSCS', 'label': 'BSCS'},
    {'value': 'BSIT', 'label': 'BSIT'},

  ];
  String? _selectedProgram;
  @override
  void initState() {
    _studentService = FirebaseCloudStorage();
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
            SelectFormField(
              controller: _program,
              type: SelectFormFieldType.dropdown,
              labelText: 'Program/Course',
              items: _programOptions,
              onChanged: (dynamic value) {
                setState(() {
                  _selectedProgram = value;
                });
              },
              onSaved: (dynamic value) {
                _selectedProgram = value;
              },
              decoration: const InputDecoration(
                hintText: 'Select your program/course',
              ),
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
                    mName: middlename,
                    dBirth: dateBirth!,
                    address: address,
                    contactNum: contactNum,
                  );

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
                }
              },
              child: const Text('Register'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute,
                  (route) => false,
                );
              },
              child: const Text('Already registered? Login here!'),
            )
          ],
        ),
      ),
    );
  }
}
