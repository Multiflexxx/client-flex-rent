import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class UserRatingBox extends StatelessWidget {
  UserRatingBox();

  @override
  Widget build(BuildContext context) {
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
            Text(
              'Titel der Beschreibung',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18.0,
                height: 1.35,
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Row(children: [
                  Icon(
                  Icons.star,
                  color: Theme.of(context).accentColor,
                ),
                  Icon(
                  Icons.star,
                  color: Theme.of(context).accentColor,
                ),
                  Icon(
                  Icons.star,
                  color: Theme.of(context).accentColor,
                ),
                  Icon(
                  Icons.star,
                  color: Theme.of(context).accentColor,
                ),
                  Icon(
                  Icons.star,
                  color: Theme.of(context).accentColor,
                ),
              ],),
                Text(
                  '01.01.1999',
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
              'Hans Peter',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16.0,
                height: 1.35,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Hier kommt die Beschreibung hin',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 14.0,
                height: 1.35,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 10.0),
            GestureDetector(
              child: Text(
                'Erzähle mir mehr',
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
