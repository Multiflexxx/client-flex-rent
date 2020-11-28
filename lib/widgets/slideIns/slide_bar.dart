import 'package:flutter/material.dart';

class SlideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10.0,
        ),
        Container(
          height: 5.0,
          width: 50.0,
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ],
    );
  }
}
