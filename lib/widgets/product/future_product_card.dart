import 'package:flutter/material.dart';
import 'package:rent/models/offer_model.dart';
import 'package:rent/models/future_product_model.dart';
import 'package:rent/widgets/price/price_tag.dart';

class FutureProductCard extends StatelessWidget {
  final FutureProduct futureProduct;

  FutureProductCard({Key key, this.futureProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 220,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Positioned(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(90.0, 0, 10, 0),
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
                              padding:
                                  EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${futureProduct.title}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.2,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  RichText(
                                      text: TextSpan(
                                    text: futureProduct.rent == true
                                        ? 'Ausleihe'
                                        : 'Miete',
                                    style: TextStyle(
                                      color: Colors.purple,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.2,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: futureProduct.rent == true
                                        ? ' vom'
                                        : ' beginnt am',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16)),
                                    ],
                                  )),
                                  // Text(
                                  //   'Gesperrt vom',
                                  //   style: TextStyle(
                                  //     color: Colors.purple,
                                  //     fontSize: 20.0,
                                  //     fontWeight: FontWeight.w700,
                                  //     letterSpacing: 1.2,
                                  //   ),
                                  //   maxLines: 1,
                                  //   overflow: TextOverflow.ellipsis,
                                  // ),
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

                                  PriceTag(futureProduct.price),
                                  Text(
                                    'Show more',
                                    style: TextStyle(
                                      color: Colors.purple,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Text(
                                  //       '4.9',
                                  //       style: TextStyle(
                                  //         color: Colors.white,
                                  //         fontSize: 16.0,
                                  //         fontWeight: FontWeight.w300,
                                  //         letterSpacing: 1.2,
                                  //       ),
                                  //     ),
                                  //     SizedBox(
                                  //       width: 5.0,
                                  //     ),
                                  //     Icon(
                                  //       Icons.star,
                                  //       color: Colors.purple,
                                  //     ),
                                  //   ],
                                  // ),
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
                  height: 200,
                  margin: EdgeInsets.fromLTRB(15.0, 0.0, 0, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image(
                      height: 100,
                      width: 200,
                      image: AssetImage(futureProduct.imageUrl),
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
