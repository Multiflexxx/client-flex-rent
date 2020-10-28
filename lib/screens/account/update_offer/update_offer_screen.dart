import 'package:flutter/material.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/screens/account/update_offer/update_offer_body.dart';
import 'package:flexrent/widgets/layout/standard_sliver_appbar_list.dart';

class UpdateOfferScreen extends StatelessWidget {
  final Offer offer;

  UpdateOfferScreen({this.offer});

  @override
  Widget build(BuildContext context) {
    return StandardSliverAppBarList(
      title: 'Bearbeiten',
      bodyWidget: UpdateOfferBody(
        offer: offer,
      ),
    );
  }
}
