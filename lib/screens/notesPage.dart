import 'package:notes/components/button.dart';
import 'package:notes/constants.dart';
import 'package:notes/screens/editNotePage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotesPage extends StatefulWidget {
  static const String id = 'notes';

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late final FirebaseAuth _auth;
  late final _user;

  @override
  void initState() {
    super.initState();

    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              AppBar(
                backgroundColor: kLightBlue,
                leading: Hero(
                  tag: 'logo',
                  child: Icon(
                    FontAwesomeIcons.stickyNote,
                    size: 40,
                    color: Colors.black,
                  ),
                ),
                title: Text(
                  'Notes',
                   style: TextStyle(
                     color: kDefaultTextColor,
                     fontSize: 25,
                   ),
                ),

              ),
              Expanded(
                  child: Container(
                    child: getNotes(),
                  )
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Button(
                      content: Text(
                        'Logout',
                        style: TextStyle(
                          color: kDefaultTextColor,
                        ),
                      ),
                      width: 290,
                      color: kBrightBlue,
                      onPress: () {
                        _auth.signOut();
                        Navigator.pop(context);
                      }
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.pushNamed(context, EditNotePage.id);
                    },
                    child: Icon(Icons.add),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getNotes() {
    return StreamBuilder<QuerySnapshot>(
        stream: kRef.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot?.data!.size ?? 0,
              itemBuilder: (context, _index) {
                var note = snapshot.data!.docs[_index];
                if (note!['author'] == _user.email) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                    color: kYellow,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditNotePage(initialTitle: note!['title'], initialContent: note!['content'])));
                        FirebaseFirestore.instance.collection('notes').doc(note.id).delete();
                      },
                      child: Column(
                          children: [
                            SizedBox(height: 8,),
                            Text(
                              'Title: ${note!['title']}',
                              style: kTitleText,
                            ),
                            SizedBox(height: 5,),
                            Text(
                              'Brief Description: ${truncate(note!['content'])}',
                            ),
                            SizedBox(height: 10,),
                          ]
                      ),
                    ),
                  );
                }
                else {
                  return (SizedBox(height: 0.0,));
                }
              },
            );
          }
          else {
            return Center(
              child: Text('There are no notes to display!'),
            );
          }
        }
    );
  }

  String truncate(String toTruncate) => (toTruncate.length > 100) ? toTruncate.substring(0, 100): toTruncate;
}
