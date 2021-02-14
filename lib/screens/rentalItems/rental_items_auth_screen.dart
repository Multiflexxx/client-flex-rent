import 'package:flexrent/screens/authentication/authentication_screen.dart';
import 'package:flexrent/screens/rentalItems/rental_items_root_screen.dart';
import 'package:flexrent/widgets/background/logo.dart';
import 'package:flexrent/widgets/layout/standard_sliver_appbar_list.dart';
import 'package:flexrent/widgets/styles/buttons_styles/button_purple_styled.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class RentalItemsAuthScreen extends StatelessWidget {
  final VoidCallback hideNavBarFunction;

  const RentalItemsAuthScreen({Key key, this.hideNavBarFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandardSliverAppBarList(
      title: 'Mietgegenstände',
      leading: Container(),
      bodyWidget: _RentalItemsAuthScreen(
        hideNavBarFunction: hideNavBarFunction,
      ),
    );
  }
}

class _RentalItemsAuthScreen extends StatelessWidget {
  final VoidCallback hideNavBarFunction;

  const _RentalItemsAuthScreen({Key key, this.hideNavBarFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.618 * MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Background(top: 0),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Melde dich an, um deine Mietgegenstände zu sehen!',
                    style: TextStyle(fontSize: 24, letterSpacing: 1.25),
                  ),
                  PurpleButton(
                    text: Text('Anmelden'),
                    onPressed: () {
                      hideNavBarFunction();
                      pushNewScreen(
                        context,
                        screen: AuthenticationScreen(
                          popRouteName: RentalItemsRootScreen.routeName,
                          targetScreen: RentalItemsRootScreen(
                            hideNavBarFunction: hideNavBarFunction,
                          ),
                          hideNavBarFunction: hideNavBarFunction,
                        ),
                        pageTransitionAnimation: PageTransitionAnimation.scale,
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
