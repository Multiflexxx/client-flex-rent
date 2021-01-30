import 'package:auto_size_text/auto_size_text.dart';
import 'package:flexrent/widgets/styles/buttons_styles/button_purple_styled.dart';
import 'package:flexrent/widgets/styles/buttons_styles/button_transparent_styled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertPopup extends StatelessWidget {
  final String title;
  final String message;
  final Function goon;

  AlertPopup({this.title, this.message, this.goon});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).backgroundColor,
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      contentPadding: EdgeInsets.all(10.0),
      content: Column(
        children: [
          Text(
            message,
            style: TextStyle(color: Theme.of(context).primaryColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        PurpleButton(
          text: Text(
            "Fortsetzen",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          onPressed: goon,
        ),
        TransparentButton(
          text: Text(
            "Abbrechen",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
