import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class RatingBox extends StatelessWidget {
  final recession;


  RatingBox({this.recession});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
      decoration: BoxDecoration(
        color: Color(0xFF202020),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Deine Bewertung:',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  height: 1.34,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 10.0,
            ),
            // StarRating(widget.rentProduct.stars),
            Row(
              children: <Widget>[
                Icon(
                  Icons.star,
                  color: Colors.purple,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Icon(
                  Icons.star,
                  color: Colors.purple,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Icon(
                  Icons.star,
                  color: Colors.purple,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Icon(
                  Icons.star,
                  color: Colors.purple,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Icon(
                  Icons.star,
                  color: Colors.white,
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            // Verification
            Text(
              recession == '' ? 'Bewerte das Produkt' : recession,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                height: 1.35,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  print('Ändern');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Center(
                    child: Text(
                      'Bewertung Anpassen',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}