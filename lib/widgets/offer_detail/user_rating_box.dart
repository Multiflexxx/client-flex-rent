import 'package:flexrent/logic/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class UserRatingBox extends StatelessWidget {
  final UserRating rating;
  final OfferRating offerRating;

  UserRatingBox({this.rating, this.offerRating});

  @override
  Widget build(BuildContext context) {
    var formatter = new DateFormat.yMMMMd("de_DE");
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            rating.headline != null ? Text(
              rating.headline,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18.0,
                height: 1.35,
              ),
            ): SizedBox(),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RatingBarIndicator(
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.purple,
                  ),
                  direction: Axis.horizontal,
                  itemCount: 5,
                  rating: rating.rating.toDouble(),
                  itemSize: 30.0,
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  rating.ratingOwner.firstName +
                      " " +
                      rating.ratingOwner.lastName,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0,
                    height: 1.35,
                  ),
                ),
                Text(
                  formatter.format(rating.updatedAt),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 12.0,
                    height: 1.35,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              rating.ratingText,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 14.0,
                height: 1.35,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 10.0),
            //should only be shown if the text is to long.
            GestureDetector(
              child: Text(
                'Mehr anzeigen',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 14.0,
                  height: 1.35,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Divider(
              height: 20.0,
              color: Theme.of(context).primaryColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // feature isn't implemented
                Text('Hat dir das geholfen'),
                Row(
                  children: [
                    GestureDetector(
                      child: Text(
                        'Ja',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12.0,
                          height: 1.35,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    GestureDetector(
                      child: Text(
                        'Nein',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12.0,
                          height: 1.35,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
