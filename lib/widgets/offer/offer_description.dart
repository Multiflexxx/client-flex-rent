import 'package:flutter/material.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/widgets/slide_bar.dart';

class ProductDescription extends StatelessWidget {
  final Offer offer;
  final ScrollController scrollController;

  ProductDescription({this.offer, this.scrollController});

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
        ),
      ),
    );
  }
}
