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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('404 - Page not found', style:
                  TextStyle(
                    fontSize: 30.0,
                    color: Colors.amber,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.home, color: Colors.white,), onPressed: (){
                  Navigator.pop(context);
              }, iconSize: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
