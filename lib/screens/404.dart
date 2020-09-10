import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class PageNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Octicons.hubot, color: Colors.white, size: 100.0,),
              Text('404 - Page not found', style:
                TextStyle(
                  fontSize: 20.0,
                ),
              ),
              IconButton(
                icon: Icon(Icons.home, color: Colors.white,), onPressed: (){
                  //Navigator.popUntil(context, RoutePredicate());
              }, iconSize: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
