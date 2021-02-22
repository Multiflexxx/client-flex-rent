import 'package:flexrent/screens/account/account_screen.dart';
import 'package:flexrent/screens/authentication/authentication_screen.dart';
import 'package:flexrent/screens/rentalItems/rental_items_root_screen.dart';
import 'package:flexrent/widgets/styles/buttons_styles/button_purple_styled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class AuthScreen extends StatelessWidget {
  static String routeName = 'authScreen';

  final VoidCallback hideNavBarFunction;
  final String realScreenName;

  const AuthScreen({Key key, this.hideNavBarFunction, this.realScreenName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
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
              title: Text(
                realScreenName == 'account' ? 'Profil' : 'Mietgegenstände',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                    child: Icon(
                      realScreenName == 'accountScreen'
                          ? Feather.user
                          : Feather.shopping_bag,
                      size: 175,
                      color: Theme.of(context).accentColor,
                    ),
                  )
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
                    Text(
                      realScreenName == 'accountScreen'
                          ? 'Melde dich an, um dein Profil zu sehen. Mit einem Profil kannst du Gegenstände ausleihen und verleihen.'
                          : 'Melde dich an, um deine Mietgegenstände zu sehen!',
                      style: TextStyle(fontSize: 20, letterSpacing: 1.25),
                    ),
                    PurpleButton(
                      text: Text('Anmelden'),
                      onPressed: () {
                        hideNavBarFunction();
                        pushNewScreen(
                          context,
                          screen: realScreenName == 'accountScreen'
                              ? AuthenticationScreen(
                                  popRouteName: AccountScreen.routeName,
                                  targetScreen: AccountScreen(
                                    hideNavBarFunction: hideNavBarFunction,
                                  ),
                                  hideNavBarFunction: hideNavBarFunction,
                                )
                              : AuthenticationScreen(
                                  popRouteName: RentalItemsRootScreen.routeName,
                                  targetScreen: RentalItemsRootScreen(
                                    hideNavBarFunction: hideNavBarFunction,
                                  ),
                                  hideNavBarFunction: hideNavBarFunction,
                                ),
                          pageTransitionAnimation:
                              PageTransitionAnimation.scale,
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
}
