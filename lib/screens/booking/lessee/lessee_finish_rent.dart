import 'dart:async';

import 'package:flexrent/logic/services/offer_service.dart';
import 'package:flexrent/widgets/booking/booking_info.dart';
import 'package:flexrent/widgets/booking/booking_overview.dart';
import 'package:flexrent/widgets/booking/booking_lessor.dart';
import 'package:flexrent/widgets/offer_detail/rating_box.dart';
import 'package:flutter/material.dart';

import 'package:flexrent/logic/models/models.dart';

import 'package:flexrent/widgets/layout/standard_sliver_appbar_list.dart';

class LesseeFinishScreen extends StatelessWidget {
  final OfferRequest offerRequest;

  LesseeFinishScreen({this.offerRequest});
  @override
  Widget build(BuildContext context) {
    return StandardSliverAppBarList(
      title: offerRequest.offer.title,
      bodyWidget: LeseeFinishBody(
        offerRequest: offerRequest,
      ),
    );
  }
}

class LeseeFinishBody extends StatefulWidget {
  final OfferRequest offerRequest;
  LeseeFinishBody({this.offerRequest});
  @override
  _LeseeFinishBodyState createState() => _LeseeFinishBodyState();
}

class _LeseeFinishBodyState extends State<LeseeFinishBody> {
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
                BookingInfo(
                  offerRequest: _offerRequest,
                  lessor: false,
                ),
                BookingOverview(offerRequest: _offerRequest),
                BookingLessor(
                  offerRequest: _offerRequest,
                  updateParentScreen: _getOfferRequestUpdate,
                ),
                _offerRequest.lessorRating != null
                    ? RatingBox(
                        offerRequest: _offerRequest,
                        rating: _offerRequest.lessorRating,
                        updateParentScreen: _getOfferRequestUpdate,
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
