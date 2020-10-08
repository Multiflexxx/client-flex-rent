import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/logic/models/offer/offer.dart';
import 'package:rent/screens/account/create_offer/add_item.dart';
import 'package:rent/widgets/items/item_card.dart';

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
                    pushNewScreen(
                      context,
                      screen: AddItem(),
                      withNavBar: false,
                    );
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
            ItemCard(offer: Offer(category: null, description: "Test", offerId: "0000", price: 20.0,title: "TestOffer", lessor: null, numberOfRatings: 0, pictureLinks: null, rating: 1.0),),
          ],
        ),
      ),
    );
  }
}
