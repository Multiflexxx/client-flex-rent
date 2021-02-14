import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flexrent/logic/blocs/authentication/authentication.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/services.dart';
import 'package:flexrent/screens/offer/offer_screen.dart';
import 'package:flexrent/widgets/layout/standard_sliver_appbar_list.dart';
import 'package:flexrent/widgets/offer/offer_card.dart';

class DiscoveryOfferListScreen extends StatelessWidget {
  static String routeName = 'discoveryOfferListScreen';

  final String carouselTitle;
  final VoidCallback hideNavBarFunction;

  const DiscoveryOfferListScreen(
      {Key key, this.carouselTitle, this.hideNavBarFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandardSliverAppBarList(
      title: carouselTitle,
      bodyWidget: DiscoveryOfferListBody(
        carouselTitle: carouselTitle,
        hideNavBarFunction: hideNavBarFunction,
      ),
    );
  }
}

class DiscoveryOfferListBody extends StatefulWidget {
  final String carouselTitle;
  final VoidCallback hideNavBarFunction;

  const DiscoveryOfferListBody(
      {Key key, this.carouselTitle, this.hideNavBarFunction})
      : super(key: key);

  @override
  _DiscoveryOfferListBodyState createState() => _DiscoveryOfferListBodyState();
}

class _DiscoveryOfferListBodyState extends State<DiscoveryOfferListBody> {
  Future<List<Offer>> offerList;
  User user;

  @override
  initState() {
    super.initState();
    final state = BlocProvider.of<AuthenticationBloc>(context).state;
    if (state != null) {
      user = state.user;
    }
    offerList = ApiOfferService().getAllDiscoveryOffers(
        postCode: user != null ? user.postCode : '68165',
        discoveryTitle: widget.carouselTitle);
  }

  List<Widget> _getWidgetList({BuildContext context, List<Offer> offerList}) {
    List<Widget> _offerList = List<Widget>();
    for (Offer offer in offerList) {
      _offerList.add(
        GestureDetector(
          onTap: () => pushNewScreenWithRouteSettings(
            context,
            screen: OfferScreen(
              offer: offer,
              heroTag: offer.offerId + offer.category.name,
              hideNavBarFunction: widget.hideNavBarFunction,
            ),
            withNavBar: false,
            settings: RouteSettings(name: OfferScreen.routeName),
          ),
          child: OfferCard(offer: offer, heroTag: offer.category.name),
        ),
      );
    }
    return _offerList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Offer>>(
      future: offerList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          return Column(
            children:
                _getWidgetList(context: context, offerList: snapshot.data),
          );
        }
        return Container(
          margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          decoration: new BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: RichText(
            text: TextSpan(
              text: 'Für die Kategorie ',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18.0,
                height: 1.35,
                fontWeight: FontWeight.w300,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: widget.carouselTitle,
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 18.0,
                    height: 1.35,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                  ),
                ),
                TextSpan(
                  text: ' sind noch keine Mietgegenstände eingestellt worden.',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18.0,
                    height: 1.35,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
