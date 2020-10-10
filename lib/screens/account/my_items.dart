import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/logic/services/services.dart';
import 'package:rent/screens/account/create_offer/add_item.dart';
import 'package:rent/widgets/items/item_card.dart';

class MyItems extends StatefulWidget {
  @override
  _MyItemsState createState() => _MyItemsState();
}

class _MyItemsState extends State<MyItems> {
  Future<List<Offer>> offerList;
  @override
  void initState() {
    super.initState();
    offerList = ApiOfferService().getOfferbyUser();
  }

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
            Expanded(
              child: FutureBuilder<List<Offer>>(
                future: offerList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ItemCard(
                          offer: snapshot.data[index],
                        );
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
