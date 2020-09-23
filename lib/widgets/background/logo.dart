import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Background extends StatelessWidget {
 final double top;
 final double left;
  Background({this.top, this.left});

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return Positioned(
      top: top ?? 10,
      left: left ?? 1,
          child: Container(
        child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              
                margin: EdgeInsets.fromLTRB(0, 90, 0, 0),
                height: 400,
                width: 400,
                child: SvgPicture.asset(
                  'assets/images/Logo_white_no_background.svg',
                  color: Color.fromARGB(75, 156, 39, 176),
                ))),
      ),
    );
  }
}
