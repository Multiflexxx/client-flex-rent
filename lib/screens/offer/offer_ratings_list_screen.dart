import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/offer_service.dart';
import 'package:flexrent/widgets/boxes/standard_box.dart';
import 'package:flexrent/widgets/layout/standard_sliver_appbar_list.dart';
import 'package:flexrent/widgets/offer_detail/rating_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OfferRatingsList extends StatelessWidget {
  final Offer offer;

  OfferRatingsList({this.offer});

  @override
  Widget build(BuildContext context) {
    return StandardSliverAppBarList(
      title: 'Bewertungen',
      bodyWidget: OfferRatingListBody(
        offer: offer,
      ),
    );
  }
}

class OfferRatingListBody extends StatefulWidget {
  final Offer offer;
  final VoidCallback hideNavBarFunction;

  const OfferRatingListBody({Key key, this.hideNavBarFunction, this.offer})
      : super(key: key);

  @override
  _OfferRatingListBodyState createState() => _OfferRatingListBodyState();
}

class _OfferRatingListBodyState extends State<OfferRatingListBody> {
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
    return FutureBuilder<OfferRatingResponse>(
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
        });
  }
}
