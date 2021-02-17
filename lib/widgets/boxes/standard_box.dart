import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StandardBox extends StatelessWidget {
  final Widget content;

  StandardBox({this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: content,
        ));
  }
}
