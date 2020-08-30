import 'package:flutter/material.dart';
import 'package:rent/screens/category/category_detail_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: Text("Page 2")),
            body: Align(
                alignment: Alignment.center,
                child: FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new ListViewPage2()));
                    },
                    child: Text("Switch Page - Leave a Like")))));
  }
}
