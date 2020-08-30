import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Cart")),
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
