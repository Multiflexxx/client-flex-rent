import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:rent/models/offer_model.dart';

class OfferScreen extends StatefulWidget {
  final Offer product;

  OfferScreen({this.product});
  @override
  _OfferScreenState createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            stretch: true,
            onStretchTrigger: () {
              return;
            },
            floating: false,
            pinned: true,
            leading: IconButton(
              icon: Icon(Feather.arrow_left),
              iconSize: 30.0,
              color: Colors.white,
              onPressed: () => Navigator.pop(context),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Feather.share),
                iconSize: 30.0,
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
              ),
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            expandedHeight: MediaQuery.of(context).size.width,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
              ],
              centerTitle: true,
              title: Text(
                widget.product.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Hero(
                    tag: widget.product.offerId,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      child: Image(
                        image: AssetImage(widget.product.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                // Price tile
                Container(
                  margin: EdgeInsets.fromLTRB(18.0, 12.0, 18.0, 12.0),
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(0xFF202020),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${widget.product.price}',
                                      style: TextStyle(
                                          color: Colors.purple,
                                          fontSize: 21.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      ' € / Tag',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 21.0,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Preisübersicht',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                print('reserverien');
                              },
                              child: Container(
                                width: 0.4 * MediaQuery.of(context).size.width,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Center(
                                  child: Text(
                                    'Reservieren',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Description
                Container(
                  margin: EdgeInsets.fromLTRB(18.0, 12.0, 18.0, 12.0),
                  // height: 80,
                  decoration: BoxDecoration(
                    color: Color(0xFF202020),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      widget.product.description,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21.0,
                        height: 1.35,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
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
