import 'package:flutter/material.dart';
import 'package:rent/models/rent_product_model.dart';

class RentProductCard extends StatelessWidget {
  final RentProduct rentProduct;

  RentProductCard({Key key, this.rentProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      height: 220,
                      decoration: BoxDecoration(
                        color: Color(0xFF202020),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Flexible(
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(90.0, 20.0, 20.0, 20.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${rentProduct.title}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.2,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  // PriceTag(rentProduct.price),
                                  RichText(
                                      text: TextSpan(
                                    text: 'Ausgeliehen',
                                    style: TextStyle(
                                      color: Colors.purple,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.2,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: ' vom',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16)),
                                    ],
                                  )),
                                  Text(
                                    '11.05.20 - 11.10.20',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.2,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    rentProduct.rating == ''
                                        ? ' Du hast den Gegenstand noch nicht bewertet'
                                        : '${rentProduct.rating}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Show more',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
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
                  width: 160,
                  height: 220,
                  margin: EdgeInsets.fromLTRB(15.0, 0.0, 0, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image(
                      height: 100,
                      width: 200,
                      image: AssetImage(rentProduct.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
