import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/logic/models/offer/offer.dart';
import 'package:rent/screens/product/offer_screen.dart';

class DiscoveryCarousel extends StatefulWidget {
  final List<Offer> offerList;
  final String carouselTitle;

  DiscoveryCarousel(this.offerList, this.carouselTitle);

  @override
  _DiscoveryCarouselState createState() => _DiscoveryCarouselState();
}

class _DiscoveryCarouselState extends State<DiscoveryCarousel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.carouselTitle,
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
              GestureDetector(
                onTap: () => print('See all'),
                child: Text(
                  'See all',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 300.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.offerList.length,
            itemBuilder: (BuildContext context, int index) {
              Offer offer = widget.offerList[index];
              return GestureDetector(
                onTap: () => pushNewScreen(
                  context,
                  screen: OfferScreen(
                    offer: offer,
                    heroTag: offer.offerId + widget.carouselTitle,
                  ),
                  withNavBar: false,
                ),
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  width: 210.0,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Positioned(
                        bottom: 15.0,
                        child: Container(
                          height: 120.0,
                          width: 200.0,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 1.0, color: Colors.purple),
                            color: Color(0xFF202020),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${offer.title}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21.0,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.2,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      // TODO
                                      // offer.category.pictureLink,
                                      Feather.activity,
                                      size: 16.0,
                                      color: Colors.purple,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      offer.category.name,
                                      style: TextStyle(
                                        color: Colors.purple,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
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
                          tag: offer.offerId + widget.carouselTitle,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: offer.pictureLinks.length == 0
                                ? Image(
                                    image:
                                        AssetImage('assets/images/noimage.png'),
                                    height: 180.0,
                                    width: 180.0,
                                    fit: BoxFit.cover,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: offer.pictureLinks[0],
                                    height: 180.0,
                                    width: 180.0,
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
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
