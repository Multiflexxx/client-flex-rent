import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/logic/exceptions/exceptions.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/logic/services/services.dart';
import 'package:rent/screens/account/create_offer/add_item_screen.dart';
import 'package:rent/screens/account/update_offer/update_offer_screen.dart';
import 'package:rent/screens/booking/lessor/lessor_rental_item_screen.dart';
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

  void _addItem() async {
    final offer = await pushNewScreen(
      context,
      screen: AddItemScreen(),
      withNavBar: false,
    );
    if (offer != null) {
      _goToEditOfferView(offer: offer);
    }
  }

  void _goToEditOfferView({Offer offer}) async {
    await pushNewScreen(
      context,
      screen: UpdateOfferScreen(
        offer: offer,
      ),
    );
    setState(() {
      offerList = ApiOfferService().getOfferbyUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () => pushNewScreen(
            context,
            screen: LessorRentalItemScreen(),
          ),
          child: Container(
            padding: EdgeInsets.all(10.0),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Feather.mail,
                      size: 30.0,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    Text(
                      'Postfach',
                      style: TextStyle(
                          fontSize: 21.0,
                          fontWeight: FontWeight.w300,
                          color: Theme.of(context).primaryColor,
                          letterSpacing: 1.2),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Ionicons.ios_arrow_forward,
                      size: 30.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 20.0,
          color: Theme.of(context).accentColor,
        ),
        FlatButton(
          color: Theme.of(context).backgroundColor,
          onPressed: () => _addItem(),
          child: Text(
            '+',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 40.0,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Offer>>(
            future: offerList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () =>
                          _goToEditOfferView(offer: snapshot.data[index]),
                      child: ItemCard(
                        offer: snapshot.data[index],
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                OfferException e = snapshot.error;
                return Center(
                  child: Text(
                    e.message,
                    style: TextStyle(
                      fontSize: 24.0,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}
