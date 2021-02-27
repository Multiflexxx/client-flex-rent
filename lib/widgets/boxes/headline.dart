import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Headline extends StatelessWidget {
  final String headline;
  final Icon icon;

  Headline({this.headline, this.icon});

  @override
  Widget build(BuildContext context) {
    return icon == null
        ? Padding(
            padding: EdgeInsets.only(left: 28.0, top:15.0,),
            child: Text(
              headline,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 21.0,
                height: 1.35,
                letterSpacing: 1.2,
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.only(left: 28.0, top:15.0,),
            child: Row(
              children: [
                icon,
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  headline,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 21.0,
                    height: 1.35,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
  }
}
