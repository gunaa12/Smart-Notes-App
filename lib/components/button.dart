import 'package:notes/constants.dart';

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Widget content;
  final Color color;
  final VoidCallback onPress;

  double width;

  Button({required this.content, required this.color, required this.onPress, this.width = kDefaultButtonWidth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: this.color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPress,
          minWidth: width,
          height: 42.0,
          child: content,
        ),
      ),
    );
  }
}