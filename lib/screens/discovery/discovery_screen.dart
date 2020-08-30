import 'package:flutter/material.dart';
import 'package:rent/screens/category/category_detail_screen.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({Key key}) : super(key: key);

  @override
  _DiscoveryScreen createState() => _DiscoveryScreen();
}

class _DiscoveryScreen extends State<DiscoveryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: Text("Page 1")),
            body: Align(
                alignment: Alignment.center,
                child: FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).push(_createRoute());
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (BuildContext context) =>
                      //             new ListViewPage()));
                    },
                    child: Text("Switch Page - Subscribe")))));
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => ListViewPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(-1.0, 0.0);
      var end = Offset.zero;

      var tween = Tween(begin: begin, end: end);

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
