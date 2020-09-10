import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppSettings extends StatefulWidget {
  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  @override

  bool Darkmode = true;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Darkmode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text('Einstellungen'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Darkmode'),
                Switch(onChanged: (bool){
                  setState(() {
                    Darkmode = bool;
                  });
                }, value: Darkmode,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
