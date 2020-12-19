import 'package:flexrent/widgets/slideIns/slideIn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/widgets/price/detail_price_overview.dart';
import 'package:flexrent/widgets/slideIns/slide_bar.dart';

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
    return SlideIn(
      top: false,
      widgetList: [
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
    );
  }
}
