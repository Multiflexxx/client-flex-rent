import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/logic/exceptions/exceptions.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/logic/services/services.dart';
import 'package:rent/screens/account/create_offer/add_item.dart';
import 'package:rent/screens/booking/lessor/lessor_booking_screen.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () => pushNewScreen(context, screen: LessorBookingScreen()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Feather.mail,
                      size: 30.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    Text(
                      'Postfach',
                      style: TextStyle(
                          fontSize: 21.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          letterSpacing: 1.2),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Ionicons.ios_arrow_forward,
                      size: 30.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 20.0,
          color: Colors.purple,
        ),
        RaisedButton(
          color: Colors.transparent,
          onPressed: () {
            pushNewScreen(
              context,
              screen: AddItem(),
              withNavBar: false,
            );
          },
          child: Text(
            '+',
            style: TextStyle(
              color: Colors.white,
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
                    return ItemCard(
                      offer: snapshot.data[index],
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
                      letterSpacing: 1.35,
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
