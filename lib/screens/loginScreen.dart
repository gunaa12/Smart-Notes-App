import 'package:notes/components/button.dart';
import 'package:notes/constants.dart';
import 'package:notes/screens/notesPage.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final FirebaseAuth _auth;

  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    super.initState();

    _auth = FirebaseAuth.instance;

    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(tag: 'logo', child: kLogo),
            SizedBox(height: 40),
            TextField(
              controller: _email,
              decoration: kInputFieldDecoration.copyWith(
                hintText: 'Enter e-mail here',
              ),
            ),
            SizedBox(height: 15,),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: kInputFieldDecoration.copyWith(
                hintText: 'Enter password here',
              ),
            ),
            SizedBox(height: 40,),
            Hero(
              tag: 'login',
              child: Button(
                content: Text(
                  'Login',
                  style: TextStyle(
                    color: kDefaultTextColor,
                  ),
                ),
                color: kYellow,
                onPress: () async {
                  final user = await _auth.signInWithEmailAndPassword(email: _email.text, password: _password.text);
                  if (user != null) {
                    Navigator.pushNamed(context, NotesPage.id);
                  }
                  else {
                    print('Something went wrong while authenticating!');
                  }
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }
}
