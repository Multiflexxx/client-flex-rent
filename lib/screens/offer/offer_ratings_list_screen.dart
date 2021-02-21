import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/offer_service.dart';
import 'package:flexrent/widgets/boxes/standard_box.dart';
import 'package:flexrent/widgets/offer_detail/rating_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OfferRatingsList extends StatefulWidget {
  final Offer offer;

  OfferRatingsList({this.offer});

  @override
  _OfferRatingsListState createState() => _OfferRatingsListState();
}

class _OfferRatingsListState extends State<OfferRatingsList> {
  Future<OfferRatingResponse> offerRatings;

  @override
  void initState() {
    try {
      offerRatings = ApiOfferService().getOfferRatingsById(offer: widget.offer);
    } catch (e) {
      print(e);
      offerRatings = null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          centerTitle: true,
          title: Text(
            'Bewertungen',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 21.0,
              letterSpacing: 1.2,
            ),
          ),
          backgroundColor: Colors.transparent,
          toolbarHeight: 0.1 * MediaQuery.of(context).size.height,
        ),
        body: ListView(
          children: [
            offerRatings == null
                ? StandardBox(
                    content: Text("Hier ist etwas schiefgelaufen"),
                  )
                : FutureBuilder(
                    future: offerRatings,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        OfferRatingResponse response = snapshot.data;
                        return Column(
                          children: response.offerRatings
                              .map((rating) => RatingBox(
                                    rating: rating,
                                  ))
                              .toList(),
                        );
                      } else {
                        return StandardBox(
                          content: Text("Noch keine Bewertungen"),
                        );
                      }
                    }),
          ],
        ));
  }
}
