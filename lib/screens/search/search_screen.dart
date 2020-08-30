import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Search")),
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
                child: Text("Switch Page - Comment"))));
  }
}
