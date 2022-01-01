import 'package:notes/components/button.dart';
import 'package:notes/constants.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditNotePage extends StatefulWidget {
  static const String id = 'editNote';

  String initialTitle;
  String initialContent;

  EditNotePage({required this.initialContent, required this.initialTitle});

  @override
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late final FirebaseAuth _auth;
  late final _user;

  late TextEditingController _title;
  late TextEditingController _content;

  @override
  void initState() {
    super.initState();

    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;

    _title = TextEditingController(text: widget.initialTitle);
    _content = TextEditingController(text: widget.initialContent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  margin: EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 5),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(border: Border.all()),
                        child: TextField(
                          controller: _title,
                          decoration: InputDecoration(hintText: '  Title'),
                        ),
                      ),
                      SizedBox(height: 15.0,),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(border: Border.all()),
                          child: TextField(
                            controller: _content,
                            maxLines: null,
                            decoration: InputDecoration(hintText: '  Content'),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  child: Button(
                    content: Icon(Icons.save),
                    width: 145,
                    color: Color(0xFF75B9BE),
                    onPress: () {
                      kRef.add({
                        'author': _user!.email,
                        'title': _title.text,
                        'content': _content.text,
                      });
                      Navigator.pop(context);
                    }
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: Button(
                    content: Icon(Icons.delete),
                    width: 145,
                    color: Color(0xFF75B9BE),
                    onPress: () {Navigator.pop(context);}
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _title.dispose();
    _content.dispose();
  }
}
