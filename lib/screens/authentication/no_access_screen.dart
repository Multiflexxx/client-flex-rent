import 'package:flexrent/widgets/background/logo.dart';
import 'package:flexrent/widgets/styles/buttons_styles/button_transparent_styled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'authentication_screen.dart';

class NoAccessScreen extends StatelessWidget {
  static String routeName = 'noAccessScreen';

  final String popRouteName;
  final Widget targetScreen;
  final VoidCallback hideNavBarFunction;

  const NoAccessScreen(
      {Key key, this.popRouteName, this.targetScreen, this.hideNavBarFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Feather.x,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              hideNavBarFunction();
              Navigator.of(context).popUntil(ModalRoute.withName(popRouteName));
            }),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: <Widget>[
          Background(top: 30),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Logge dich ein, um diese Funktion frei zu schalten!',
                    style: TextStyle(fontSize: 24, letterSpacing: 1.25),
                  ),
                  TransparentButton(
                    text: Text('Anmelden'),
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return AuthenticationScreen(
                              popRouteName: popRouteName,
                              targetScreen: targetScreen,
                              hideNavBarFunction: hideNavBarFunction,
                            );
                          },
                        ),
                        ModalRoute.withName(popRouteName),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
