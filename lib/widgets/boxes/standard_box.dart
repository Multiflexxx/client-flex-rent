import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StandardBox extends StatelessWidget {
  final Widget content;
  final bool margin;

  StandardBox({this.content, this.margin = true});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin
            ? EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0)
            : EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
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
