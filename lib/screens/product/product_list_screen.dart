import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/logic/services/offer_service.dart';
import 'package:rent/screens/product/product_screen.dart';
import 'package:rent/widgets/product/product_card.dart';

class ProductListScreen extends StatefulWidget {
  final Category category;

  const ProductListScreen({this.category});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  Future<List<Offer>> offerList;

  @override
  initState() {
    super.initState();
    offerList =
        ApiOfferService().getAllOffers(category: widget.category.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.category.name),
      ),
      body: FutureBuilder<List<Offer>>(
        future: offerList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                Offer offer = snapshot.data[index];
                return GestureDetector(
                  onTap: () => pushNewScreen(
                    context,
                    screen: OfferScreen(offer: offer),
                    withNavBar: false,
                  ),
                  child: ProductCard(offer: offer),
                );
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
