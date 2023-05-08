import 'package:flutter/material.dart';
import 'package:hnu_mis_announcement/services/auth/auth_service.dart';
import 'package:hnu_mis_announcement/views/constants/route.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification',
        style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 60),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
          ),
          const SizedBox(height: 15),
          Container(
            height: 500.0,
            width: 330.0,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(30),
              //image: const DecorationImage(
                //image: AssetImage('assets/email_verification.png'),
                //alignment: Alignment.center
             // ),
            ),
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                //const SizedBox(height: 5),
                const Text(
                  "Verify Your Account",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 12),
                const Text(
                  "We've sent you an email verification. Please open it to verify your account."
                      " If you haven't received the email yet, please check your spam folder.",
                  style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.justify,
                ),
                //const SizedBox(height: 10),
                SizedBox(
                  height: 240,
                  child: Image.asset(
                    'assets/email_verification.png',
                    fit: BoxFit.contain,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await AuthService.firebase().sendEmailVerification();
                  },
                  child: const Text('Send email verification',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await AuthService.firebase().logout();
                    if (!mounted) return;
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      registerRoute,
                          (route) => false,
                    );
                  },
                  child: const Text('Restart',
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),

          //const Text(
              //"We've sent you an email verification. Please open it to verify your account"),
          //const Text(
              //"If you haven't received a verification email yet, press the button below"),


        ],
      ),
    );
  }
}
