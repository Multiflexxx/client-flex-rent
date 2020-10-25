import 'package:flutter/material.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/screens/account/update_offer/update_offer_body.dart';
import 'package:rent/widgets/layout/standard_sliver_appbar_list.dart';

class UpdateOfferScreen extends StatelessWidget {
  final Offer offer;

  UpdateOfferScreen({this.offer});

  @override
  Widget build(BuildContext context) {
    return StandardSliverAppBarList(
      title: 'Änderungen',
      bodyWidget: UpdateOfferBody(
        offer: offer,
      ),
    );
  }
}
