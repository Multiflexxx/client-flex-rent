import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final double price;

  PriceTag(this.price);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$price',
          style: TextStyle(
              color: Colors.purple,
              fontSize: 18.0,
              fontWeight: FontWeight.w600),
        ),
        Text(
          ' € / Tag',
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 18.0,
              fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
