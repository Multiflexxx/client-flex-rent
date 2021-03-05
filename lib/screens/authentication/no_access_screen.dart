import 'package:flexrent/screens/authentication/authentication_screen.dart';
import 'package:flexrent/widgets/styles/buttons_styles/button_purple_styled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lottie/lottie.dart';

class NoAccessScreen extends StatelessWidget {
  static String routeName = 'noAccessScreen';

  final String popRouteName;
  final Widget targetScreen;
  final VoidCallback hideNavBarFunction;
  final String realScreenName;

  const NoAccessScreen(
      {Key key,
      this.popRouteName,
      this.targetScreen,
      this.hideNavBarFunction,
      this.realScreenName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            leading: _handleBackButton(context: context),
            stretch: true,
            onStretchTrigger: () {
              return;
            },
            floating: false,
            pinned: true,
            backgroundColor: Theme.of(context).backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            expandedHeight: MediaQuery.of(context).size.width,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
              ],
              centerTitle: true,
              title: _buildTitle(context: context),
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  _buildIcon(context: context),
                ],
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(<Widget>[
            SizedBox(
              height: 10.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
              height: 0.25 * MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                      width: 2.0, color: Theme.of(context).accentColor)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildText(context: context),
                    PurpleButton(
                      text: Text('Anmelden'),
                      onPressed: () {
                        hideNavBarFunction();
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
            )
          ]))
        ],
      ),
    );
  }

  Widget _handleBackButton({BuildContext context}) {
    if (realScreenName == 'reservationScreen') {
      return IconButton(
        icon: Icon(
          Feather.x,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () {
          hideNavBarFunction();
          Navigator.of(context).popUntil(ModalRoute.withName(popRouteName));
        },
      );
    }
    return Container();
  }

  Widget _buildTitle({BuildContext context}) {
    String _title = 'Mietgegenstände';
    if (realScreenName == 'accountScreen') {
      _title = 'Profil';
    } else if (realScreenName == 'reservationScreen') {
      _title = 'Reservieren';
    } else if (realScreenName == 'chatOverviewScreen') {
      _title = 'Chat';
    }
    return Text(
      _title,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildIcon({BuildContext context}) {
    IconData _icon = Feather.shopping_bag;
    String _lottie = '';
    if (realScreenName == 'accountScreen') {
      _icon = Feather.user;
    } else if (realScreenName == 'reservationScreen') {
      _icon = Feather.dollar_sign;
    } else if (realScreenName == 'chatOverviewScreen') {
      _lottie = 'assets/lottie/chat.json';
    }
    return _lottie != ''
        ? Lottie.asset(
            _lottie,
            height: 400,
          )
        : Icon(
            _icon,
            size: 150,
            color: Theme.of(context).accentColor,
          );
  }

  Widget _buildText({BuildContext context}) {
    String _text = 'Melde dich an, um deine Mietgegenstände zu sehen!';
    if (realScreenName == 'accountScreen') {
      _text =
          'Melde dich an, um dein Profil zu sehen. Mit einem Profil kannst du Gegenstände ausleihen und verleihen.';
    } else if (realScreenName == 'reservationScreen') {
      _text = 'Melde dich an, um Gegenstände ausleihen zu können!';
    } else if (realScreenName == 'chatOverviewScreen') {
      _text =
          'Melde dich an, um mit anderen Nutzern zu Chatten und Gegenstände ausleihen zu können!';
    }
    return Text(
      _text,
      style: TextStyle(fontSize: 14, letterSpacing: 1.25),
    );
  }
}
