import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_view.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify email')),
      body: Column(children: [
        const Text('Please verify your email address:'),
        TextButton(
          onPressed: () async {
            final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
          },
          child: const Text('Send email verification'),
        ),
        TextButton(onPressed: () {
Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const LoginView()),);
        }, child: const Text('Login'))
      ]),
    );
  }
}
