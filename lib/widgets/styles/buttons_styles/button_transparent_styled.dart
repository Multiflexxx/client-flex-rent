import 'package:flutter/material.dart';

class TransparentButton extends StatelessWidget {
  @required
  final VoidCallback onPressed;
  @required
  final Text text;

  TransparentButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.transparent,
        textColor: Theme.of(context).primaryColor,
        padding: const EdgeInsets.all(16),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(8.0),
            side:
                BorderSide(color: Theme.of(context).accentColor, width: 1.75)),
        child: text,
        onPressed: onPressed,
      ),
    );
  }
}
