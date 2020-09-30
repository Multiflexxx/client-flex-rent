import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class UserBox extends StatelessWidget {
  UserBox();

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Vermieter/in: Tristan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        height: 1.35,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      'Flexer seit August 2020',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image(
                    width: 75,
                    height: 75,
                    image: AssetImage('assets/images/jett.jpg'),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.star,
                  color: Colors.purple,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  '69 Bewertungen',
                  style: TextStyle(
                    color: Colors.white,
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
                  color: Colors.purple,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Identität verifiziert',
                  style: TextStyle(
                    color: Colors.white,
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
            Center(
              child: GestureDetector(
                onTap: () {
                  print('kontaktieren');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Center(
                    child: Text(
                      'Vermieter kontaktieren',
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