import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent/models/offer_model.dart';
import 'package:rent/widgets/price/detail_price_overview.dart';
import 'package:rent/widgets/slide_bar.dart';

class PriceOverview extends StatelessWidget {
  final double price;
  final ScrollController scrollController;
  final bool reverse;
  final DateTime startDate;
  final DateTime endDate;

  PriceOverview({
    Key key,
    this.price,
    this.scrollController,
    this.reverse = false,
    this.startDate,
    this.endDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFF202020),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SlideBar(),
            SizedBox(
              height: 10.0,
            ),
            DetailPriceOverview(
              price: price,
              startDate: startDate,
              endDate: endDate,
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
