import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/screens/account/create_offer/add_item.dart';

class MyItems extends StatefulWidget {
  @override
  _MyItemsState createState() => _MyItemsState();
}

class _MyItemsState extends State<MyItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meine Mietgegenstände'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: () {
                    pushNewScreenWithRouteSettings(
                      context,
                      settings: RouteSettings(name: 'AddItem'),
                      screen: AddItem(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );

                    // Navigator.push(context,
                    //     new CupertinoPageRoute(builder: (BuildContext context) {
                    //   return AddItem();
                    // }));
                  },
                  child: Text(
                    '+',
                    style: TextStyle(color: Colors.white, fontSize: 40.0),
                  ),
                ),
              ),
              shadowColor: Colors.purple,
              color: Colors.black,
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text('iPhone 11'),
                    subtitle: Text('Apple'),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('Bearbeiten'),
                        onPressed: () {/* ... */},
                      ),
                      FlatButton(
                        child: const Text('Verfügbarkeit ändern'),
                        onPressed: () {/* ... */},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
