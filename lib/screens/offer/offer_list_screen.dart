import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/logic/blocs/authentication/authentication.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/logic/services/services.dart';
import 'package:rent/screens/offer/offer_screen.dart';
import 'package:rent/widgets/layout/standard_sliver_appbar_list.dart';
import 'package:rent/widgets/offer/offer_card.dart';

class ProductListScreen extends StatelessWidget {
  final Category category;

  ProductListScreen({this.category});

  @override
  Widget build(BuildContext context) {
    return StandardSliverAppBarList(
      title: category.name,
      bodyWidget: ProductListBody(
        category: category,
      ),
    );
  }
}

class ProductListBody extends StatefulWidget {
  final Category category;

  ProductListBody({this.category});

  @override
  _ProductListBodyState createState() => _ProductListBodyState();
}

class _ProductListBodyState extends State<ProductListBody> {
  Future<List<Offer>> offerList;
  User user;

  @override
  initState() {
    super.initState();
    final state = BlocProvider.of<AuthenticationBloc>(context).state
        as AuthenticationAuthenticated;
    user = state.user;
    offerList = ApiOfferService().getAllOffers(
        postCode: user.postCode, category: widget.category.categoryId);
  }

  List<Widget> _getWidgetList({BuildContext context, List<Offer> offerList}) {
    List<Widget> _offerList = List<Widget>();
    for (Offer offer in offerList) {
      _offerList.add(
        GestureDetector(
          onTap: () => pushNewScreen(
            context,
            screen: OfferScreen(
              offer: offer,
              heroTag: offer.offerId + offer.category.name,
            ),
            withNavBar: false,
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
        if (snapshot.hasData) {
          return Column(
            children:
                _getWidgetList(context: context, offerList: snapshot.data),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
