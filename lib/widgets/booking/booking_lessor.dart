import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flexrent/logic/models/offer_request/offer_request.dart';

class BookingLessor extends StatelessWidget {
  final OfferRequest offerRequest;
  BookingLessor({this.offerRequest});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'VermieterIn: ' +
                            offerRequest.offer.lessor.firstName + ' ' +
                            offerRequest.offer.lessor.lastName,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18.0,
                          height: 1.2,
                          
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1.2,
                        ),
                        maxLines: 2,
                      ),
                      // missing in backend
                      // Text(
                      //   'Flexer seit ' + offerRequest.user.cakeday,
                      // )
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Flexer seit 06.09.420',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16.0,
                          height: 1.0,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1.2,
                        ),
                      )
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: offerRequest.user.profilePicture != ''
                      ? CachedNetworkImage(
                          imageUrl: offerRequest.user.profilePicture,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Image(
                            width: 70,
                            height: 70,
                            image: AssetImage('assets/images/jett.jpg'),
                          ),
                          errorWidget: (context, url, error) => Image(
                            width: 70,
                            height: 70,
                            image: AssetImage('assets/images/jett.jpg'),
                          ),
                        )
                      : Image(
                          width: 70,
                          height: 70,
                          image: AssetImage('assets/images/jett.jpg'),
                        ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.star,
                  color: Theme.of(context).accentColor,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Vermieterbewertung: ${offerRequest.offer.lessor.lessorRating} (${offerRequest.offer.lessor.numberOfLessorRatings})',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18.0,
                    height: 1.35,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            // Verification
            Row(
              children: <Widget>[
                Icon(
                  Icons.verified_user,
                  color: Theme.of(context).accentColor,
                ),
                SizedBox(
                  width: 10.0,
                ),
                offerRequest.user.verified
                    ? Text(
                        'Identität verifiziert',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18.0,
                          height: 1.35,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    : Text(
                        'Identität nicht verifiziert',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18.0,
                          height: 1.35,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                textColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.all(16),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8.0)),
                child: Text('Bewerte den Vermieter'),
                onPressed: () {
                  ;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
