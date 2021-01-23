import 'package:flexrent/widgets/slideIns/slideIn.dart';
import 'package:flutter/material.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/widgets/slideIns/slide_bar.dart';

class ProductDescription extends StatelessWidget {
  final Offer offer;
  final ScrollController scrollController;

  ProductDescription({this.offer, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return SlideIn(
      widgetList: [
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                offer.title,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18.0,
                    height: 1.35,
                    decoration: TextDecoration.underline),
              ),
              SizedBox(height: 10.0),
              Text(
                offer.description,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16.0,
                  height: 1.35,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
