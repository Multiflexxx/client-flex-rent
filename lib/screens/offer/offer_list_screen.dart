import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/logic/blocs/authentication/authentication.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/logic/services/services.dart';
import 'package:rent/screens/offer/offer_screen.dart';
import 'package:rent/widgets/offer/offer_card.dart';

class ProductListScreen extends StatefulWidget {
  final Category category;

  const ProductListScreen({this.category});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.category.name),
      ),
      body: FutureBuilder<List<Offer>>(
        future: offerList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                Offer offer = snapshot.data[index];
                return GestureDetector(
                  onTap: () => pushNewScreen(
                    context,
                    screen: OfferScreen(
                      offer: offer,
                      heroTag: offer.offerId + offer.category.name,
                    ),
                    withNavBar: false,
                  ),
                  child: OfferCard(offer: offer, heroTag: offer.category.name),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
