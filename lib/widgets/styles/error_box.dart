import 'package:flutter/material.dart';

class ErrorBox extends StatelessWidget {
  final String errorText;

  ErrorBox({this.errorText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      decoration: new BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        errorText,
        style: TextStyle(
          fontSize: 16.0,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
