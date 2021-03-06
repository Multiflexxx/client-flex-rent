import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

Widget showFlushbar({BuildContext context, String message}) {
  return Flushbar(
    messageText: Text(
      message,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 16.0,
        letterSpacing: 1.2,
      ),
    ),
    icon: Icon(
      Icons.info_outline,
      size: 24.0,
      color: Theme.of(context).accentColor,
    ),
    duration: Duration(seconds: 3),
    margin: EdgeInsets.all(10.0),
    padding: EdgeInsets.all(16.0),
    borderRadius: 8,
  )..show(context);
}
