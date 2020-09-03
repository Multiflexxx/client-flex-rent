import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Account")),
        body: ListView(
          children: [
            ListTile(
              leading: Icon(IconData(59486, fontFamily: 'MaterialIcons'), color: Colors.white),
              title: Text(
                'Meine Informationen',
              style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: FlutterLogo(),
              title: Text(
                'Einstellungen',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: FlutterLogo(),
              title: Text(
                'Meine Produkte',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: FlutterLogo(),
              title: Text(
                'Abmelden',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: FlutterLogo(),
              title: Text(
                'One-line with leading widget',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: FlutterLogo(),
              title: Text(
                'One-line with leading widget',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: FlutterLogo(),
              title: Text(
                'One-line with leading widget',
                style: TextStyle(color: Colors.white),
              ),
            ),ListTile(
              leading: FlutterLogo(),
              title: Text(
                'One-line with leading widget',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: FlutterLogo(),
              title: Text(
                'One-line with leading widget',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: FlutterLogo(),
              title: Text(
                'One-line with leading widget',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: FlutterLogo(),
              title: Text(
                'One-line with leading widget',
                style: TextStyle(color: Colors.white),
              ),
            ),ListTile(
              leading: FlutterLogo(),
              title: Text(
                'One-line with leading widget',
                style: TextStyle(color: Colors.white),
              ),
            ),


          ],

        )
        );
  }
}
