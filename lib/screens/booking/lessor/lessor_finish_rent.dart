import 'dart:async';

import 'package:flexrent/logic/services/offer_service.dart';
import 'package:flexrent/widgets/booking/booking_info.dart';
import 'package:flexrent/widgets/booking/booking_lessee.dart';
import 'package:flexrent/widgets/booking/booking_overview.dart';
import 'package:flexrent/widgets/boxes/headline.dart';
import 'package:flexrent/widgets/offer_detail/rating_box.dart';
import 'package:flutter/material.dart';

import 'package:flexrent/logic/models/models.dart';

import 'package:flexrent/widgets/layout/standard_sliver_appbar_list.dart';
import 'package:flutter_icons/flutter_icons.dart';

class LessorFinishScreen extends StatelessWidget {
  final OfferRequest offerRequest;

  LessorFinishScreen({this.offerRequest});
  @override
  Widget build(BuildContext context) {
    return StandardSliverAppBarList(
      title: offerRequest.offer.title,
      bodyWidget: LessorFinishBody(
        offerRequest: offerRequest,
      ),
    );
  }
}

class LessorFinishBody extends StatefulWidget {
  final OfferRequest offerRequest;
  LessorFinishBody({this.offerRequest});
  @override
  _LessorFinishBodyState createState() => _LessorFinishBodyState();
}

class _LessorFinishBodyState extends State<LessorFinishBody> {
  Future<OfferRequest> offerRequest;

  @override
  void initState() {
    super.initState();
    _getOfferRequestUpdate();
  }

  void _getOfferRequestUpdate() {
    setState(() {
      offerRequest = ApiOfferService()
          .getOfferRequestbyRequest(offerRequest: widget.offerRequest);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: offerRequest,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            OfferRequest _offerRequest = snapshot.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BookingInfo(offerRequest: _offerRequest, lessor: true),
                
                BookingOverview(offerRequest: _offerRequest),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Headline(headline: 'Mieter',),
                  ],
                ),
                BookingLessee(
                  offerRequest: _offerRequest,
                  updateParentScreen: _getOfferRequestUpdate,
                ),
                _offerRequest.lesseeRating != null
                    ?  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Headline(headline: 'Deine Bewertung des Mieters',),
                    RatingBox(
                        offer: _offerRequest.offer,
                        rating: _offerRequest.lesseeRating,
                        updateParentScreen: _getOfferRequestUpdate,
                      )
                  ],
                )
                    : Container(),
                SizedBox(
                  height: 75.0,
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
