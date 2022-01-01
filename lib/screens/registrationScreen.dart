import 'package:notes/components/button.dart';
import 'package:notes/constants.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes/screens/notesPage.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String _email;
  late String _password;
  late FirebaseAuth auth;

  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(tag: 'logo', child: kLogo),
              SizedBox(height: 40,),
              TextField(
                onChanged: (String text) {
                  _email = text;
                },
                decoration: kInputFieldDecoration.copyWith(
                  hintText: 'Enter e-mail here',
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                obscureText: true,
                onChanged: (String text) {
                  _password = text;
                },
                decoration: kInputFieldDecoration.copyWith(
                  hintText: 'Enter password here',
                ),
              ),
              SizedBox(height: 40,),
              Hero(
                tag: 'register',
                child: Button(
                    content: Text(
                      'Register',
                      style: TextStyle(
                        color: kDefaultTextColor,
                      ),
                    ),
                    color: Color(0xFFD1603D),
                    onPress: () async {
                      try {
                        print(_email);
                        print(_password);
                        await auth.createUserWithEmailAndPassword(
                            email: _email, password: _password);
                        Navigator.pushNamed(context, NotesPage.id);
                      }
                      catch (e) {
                        print(e);
                      }
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
