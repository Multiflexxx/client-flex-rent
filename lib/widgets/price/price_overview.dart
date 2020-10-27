import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/widgets/price/detail_price_overview.dart';
import 'package:rent/widgets/slide_bar.dart';

class PriceOverview extends StatelessWidget {
  final double price;
  final ScrollController scrollController;
  final bool reverse;
  final DateRange dateRange;

  PriceOverview({
    Key key,
    this.price,
    this.scrollController,
    this.reverse = false,
    this.dateRange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
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
              dateRange: dateRange,
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
