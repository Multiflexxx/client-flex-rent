import 'package:flutter/material.dart';
import 'package:rent/logic/models/models.dart';

class AddImages extends StatefulWidget {
  final Future<Offer> offer;

  AddImages({this.offer});

  @override
  _AddImagesState createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[Text('Ist das richtig?')],
        ),
      ),
    );
  }
}
