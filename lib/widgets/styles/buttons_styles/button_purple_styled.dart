import 'package:flutter/material.dart';

class PurpleButton extends StatelessWidget {
  @required
  final VoidCallback onPressed;
  @required
  final Text text;

  PurpleButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        color: Theme.of(context).accentColor,
        textColor: Colors.white,
        padding: const EdgeInsets.all(16),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(8.0)),
        child: text,
        onPressed: onPressed,
      ),
    );
  }
}
