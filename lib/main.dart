import 'package:notes/screens/editNotePage.dart';
import 'package:notes/screens/homeScreen.dart';
import 'package:notes/screens/loginScreen.dart';
import 'package:notes/screens/notesPage.dart';
import 'package:notes/screens/registrationScreen.dart';

import 'package:flutter/material.dart';

void main() => runApp(Notes());

class Notes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        NotesPage.id: (context) => NotesPage(),
        EditNotePage.id: (context) => EditNotePage(initialContent: '', initialTitle: '',),
      },
    );
  }
}