import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: Text("Page 3")),
            body: Align(
                alignment: Alignment.center,
                child: FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (BuildContext context) =>
                      //             new ListViewPage()));
                    },
                    child: Text("Switch Page - Comment")))));
  }
}
