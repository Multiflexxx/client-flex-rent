import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/widgets/price/price_tag.dart';

class OfferCard extends StatelessWidget {
  final Offer offer;
  final String heroTag;

  OfferCard({Key key, this.offer, this.heroTag}) : super(key: key);

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
                        color: Theme.of(context).cardColor,
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
                                    offer.title,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.2,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    offer.description,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 1.2,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  PriceTag(offer.price),
                                  offer.rating == 0.0
                                      ? Row(
                                          children: [
                                            Text(
                                              "Keine Bewertung",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w300,
                                                letterSpacing: 1.2,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Text(
                                              offer.rating.toString(),
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
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
                                        color: Theme.of(context).accentColor,
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
                  width: 170.0,
                  height: 200.0,
                  margin: EdgeInsets.fromLTRB(15.0, 0.0, 0, 0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Hero(
                    tag: offer.offerId + heroTag,
                    transitionOnUserGestures: true,
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
                                color: Theme.of(context).primaryColor,
                              ),
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                                color: Theme.of(context).primaryColor,
                              ),
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
