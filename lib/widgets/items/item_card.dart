import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent/logic/models/offer/offer.dart';
import 'package:rent/widgets/price/price_tag.dart';

class ItemCard extends StatelessWidget {
  final Offer offer;

  ItemCard({this.offer});

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
                              padding:
                                  EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
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
                                      Text('Frei'),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        child: const Text(
                                          'Bearbeiten',
                                          style: TextStyle(
                                            color: Colors.purple,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w300,
                                            letterSpacing: 1.0,
                                          ),
                                        ),
                                        onTap: () {/* */},
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      GestureDetector(
                                        child: const Text(
                                          'Verfügbarkeit ändern',
                                          style: TextStyle(
                                            color: Colors.purple,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w300,
                                            letterSpacing: 1.0,
                                          ),
                                        ),
                                        onTap: () {/* */},
                                      )
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
                  width: 170.0,
                  height: 200.0,
                  margin: EdgeInsets.fromLTRB(15.0, 0.0, 0, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: offer.pictureLinks.length == 0
                        ? Image(
                            image: AssetImage('assets/images/noimage.png'),
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: offer.pictureLinks[0],
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Icon(
                              Icons.error,
                              color: Colors.white,
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              color: Colors.white,
                            ),
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
