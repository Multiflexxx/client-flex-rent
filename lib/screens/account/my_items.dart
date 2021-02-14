import 'package:flexrent/logic/blocs/authentication/authentication.dart';
import 'package:flexrent/screens/account/account_screen.dart';
import 'package:flexrent/widgets/styles/error_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flexrent/logic/exceptions/exceptions.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/services.dart';
import 'package:flexrent/screens/account/create_offer/add_item_screen.dart';
import 'package:flexrent/screens/account/update_offer/update_offer_screen.dart';
import 'package:flexrent/screens/booking/lessor/lessor_rental_item_screen.dart';
import 'package:flexrent/widgets/items/item_card.dart';

class MyItems extends StatefulWidget {
  final VoidCallback hideNavBarFunction;

  const MyItems({Key key, this.hideNavBarFunction}) : super(key: key);

  @override
  _MyItemsState createState() => _MyItemsState();
}

class _MyItemsState extends State<MyItems> {
  Future<List<Offer>> offerList;
  @override
  void initState() {
    super.initState();
    if (HelperService.isLoggedIn(context: context)) {
      offerList = ApiOfferService().getOfferbyUser();
    }
  }

  void _goToEditOfferView({Offer offer}) {
    pushNewScreenWithRouteSettings(
      context,
      screen: UpdateOfferScreen(
        offer: offer,
        updateParentFunction: _updateOfferList,
      ),
      settings: RouteSettings(name: UpdateOfferScreen.routeName),
    );
  }

  void _updateOfferList() {
    setState(() {
      offerList = ApiOfferService().getOfferbyUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationAuthenticated ||
            state is AuthenticationNotAuthenticated) {
          setState(() {
            offerList = ApiOfferService().getOfferbyUser();
          });
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () => HelperService.pushToProtectedScreen(
              context: context,
              targetScreen: LessorRentalItemScreen(),
              popRouteName: AccountScreen.routeName,
              hideNavBar: false,
              hideNavBarFunction: widget.hideNavBarFunction,
            ),
            child: Container(
              padding: EdgeInsets.all(10.0),
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Feather.mail,
                        size: 30.0,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 25.0,
                      ),
                      Text(
                        'Postfach',
                        style: TextStyle(
                            fontSize: 21.0,
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).primaryColor,
                            letterSpacing: 1.2),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Ionicons.ios_arrow_forward,
                        size: 30.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 20.0,
            color: Theme.of(context).accentColor,
          ),
          FlatButton(
            color: Theme.of(context).backgroundColor,
            onPressed: () {
              HelperService.pushToProtectedScreen(
                context: context,
                targetScreen:
                    AddItemScreen(updateParentFunction: _updateOfferList),
                popRouteName: AccountScreen.routeName,
                hideNavBar: false,
                hideNavBarFunction: widget.hideNavBarFunction,
              );
            },
            child: Text(
              '+',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 40.0,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: FutureBuilder<List<Offer>>(
              future: offerList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () =>
                            _goToEditOfferView(offer: snapshot.data[index]),
                        child: ItemCard(
                          offer: snapshot.data[index],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  OfferException e = snapshot.error;
                  return ErrorBox(errorText: e.message);
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
