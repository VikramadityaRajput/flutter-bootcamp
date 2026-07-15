import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/rounded_button.dart';
import '../constants.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance; // the Firebase auth service

  String email = '';
  String password = '';
  bool showSpinner = false;
  String? errorMessage;

  Future<void> logIn() async {
    setState(() {
      showSpinner = true;
      errorMessage = null;
    });

    try {
      // Ask Firebase to sign this user in. `await` because it's a network call.
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (!mounted) return;
      Navigator.pushNamed(context, ChatScreen.id);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message; // e.g. "wrong password"
      });
    } finally {
      if (mounted) {
        setState(() {
          showSpinner = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Same tag as the welcome screen → the logo flies between them.
                const Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: FlutterLogo(size: 200.0),
                  ),
                ),
                const SizedBox(height: 48.0),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email',
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  obscureText: true, // hides the password
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password',
                  ),
                ),
                if (errorMessage != null) ...[
                  const SizedBox(height: 12.0),
                  Text(
                    errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
                const SizedBox(height: 24.0),
                RoundedButton(
                  title: 'Log In',
                  colour: Colors.lightBlueAccent,
                  onPressed: logIn,
                ),
              ],
            ),
          ),
          // A simple loading overlay while the network call is in flight.
          if (showSpinner)
            Container(
              color: Colors.black26,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
