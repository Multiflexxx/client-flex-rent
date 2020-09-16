import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/models/offer_model.dart';
import 'package:rent/screens/product/product_screen.dart';
import 'package:rent/widgets/product/product_card.dart';

class ProductListScreen extends StatelessWidget {
  final String category;

  const ProductListScreen(this.category);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(category),
      ),
      body: ListView.builder(
        itemCount: productSuggestionList.length,
        itemBuilder: (context, index) {
          Offer offer = productSuggestionList[index];
          return GestureDetector(
            onTap: () => pushNewScreen(
              context,
              screen: OfferScreen(offer: offer),
              withNavBar: false,
            ),
            child: ProductCard(offer: offer),
          );
        },
      ),
    );
  }
}
