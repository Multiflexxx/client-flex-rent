import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/models/offer_model.dart';
import 'package:rent/screens/product/product_screen.dart';
import 'package:rent/widgets/price_tag.dart';

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
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 240,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: <Widget>[
                        Positioned(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              margin: EdgeInsets.fromLTRB(100.0, 0, 10, 0),
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Color(0xFF202020),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          100.0, 20.0, 20.0, 20.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            '${offer.title}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 1.2,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            '${offer.description}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w300,
                                              letterSpacing: 1.2,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          PriceTag(offer.price),
                                          Row(
                                            children: [
                                              Text(
                                                '4.9',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w300,
                                                  letterSpacing: 1.2,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.0,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.purple,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 170,
                          height: 200,
                          margin: EdgeInsets.fromLTRB(15.0, 0.0, 0, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image(
                              height: 100,
                              width: 200,
                              image: AssetImage(offer.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
