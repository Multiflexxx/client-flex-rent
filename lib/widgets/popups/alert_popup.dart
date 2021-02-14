import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertPopup extends StatelessWidget {
  final String title;
  final String message;
  final Function goon;

  AlertPopup({this.title, this.message, this.goon});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      contentPadding: EdgeInsets.only(top: 10.0),
      content: Container(
        width: 0.75 * MediaQuery.of(context).size.width,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 21.0),
                )
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Divider(
              color: Theme.of(context).accentColor,
              height: 4.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                message,
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: Theme.of(context).accentColor, width: 0.5),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          "Abbrechen",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: goon,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          "Fortsetzen",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
