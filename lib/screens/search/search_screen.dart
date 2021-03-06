import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flexrent/logic/blocs/authentication/authentication.dart';
import 'package:flexrent/logic/exceptions/exceptions.dart';
import 'package:flexrent/logic/services/services.dart';
import 'package:flexrent/screens/offer/offer_screen.dart';
import 'package:flexrent/widgets/styles/divider_with_text.dart';
import 'package:flexrent/widgets/offer/offer_card.dart';
import '../../logic/models/models.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = 'searchScreen';

  final VoidCallback hideNavBarFunction;

  const SearchScreen({Key key, this.hideNavBarFunction}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = new TextEditingController();

  User user;
  Future<List<Offer>> _searchOfferList;
  List<dynamic> _suggestedList = List<String>();

  @override
  void initState() {
    super.initState();
    final state = BlocProvider.of<AuthenticationBloc>(context).state;
    if (state != null) {
      user = state.user;
    }
    getSuggestions();
  }

  void getSuggestions() async {
    _suggestedList = await ApiOfferService().getSuggestion();
  }

  void deleteSuggestions() {
    ApiOfferService().deleteSuggestion();
    setState(() {
      getSuggestions();
    });
  }

  void initiateSearch(String query) {
    if (query.length > 2) {
      _searchOfferList = ApiOfferService().getAllOffers(
          postCode: user != null ? user.postCode : '68165',
          search: query,
          limit: 3);
      ApiOfferService().setSuggestion(query: query);
    }
  }

  @override
  Widget build(BuildContext context) {
    _searchController.addListener(() {
      setState(() {});
    });
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(12.0),
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  cursorColor: Theme.of(context).accentColor,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                  ),
                  onSubmitted: (query) {
                    initiateSearch(query);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).backgroundColor,
                    hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                    hintText: "Suche",
                    contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                    prefixIcon: BackButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    suffixIcon: _searchController.text.length > 0
                        ? IconButton(
                            icon: Icon(
                              Feather.x,
                            ),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              setState(() {
                                getSuggestions();
                                _searchController.clear();
                                _searchOfferList = Future.value();
                              });
                            },
                          )
                        : null,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Expanded(
                child: FutureBuilder<List<Offer>>(
                  future: _searchOfferList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      return Column(
                        children: <Widget>[
                          DividerWithText(
                            dividerText: 'Ergebnisse',
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                Offer offer = snapshot.data[index];
                                return GestureDetector(
                                  onTap: () => pushNewScreenWithRouteSettings(
                                    context,
                                    screen: OfferScreen(
                                      offer: offer,
                                      heroTag: offer.offerId + 'search',
                                      hideNavBarFunction:
                                          widget.hideNavBarFunction,
                                    ),
                                    withNavBar: false,
                                    settings: RouteSettings(
                                        name: OfferScreen.routeName),
                                  ),
                                  child: OfferCard(
                                      offer: offer, heroTag: 'search'),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      OfferException e = snapshot.error;
                      return Text(e.message);
                    }
                    return Column(
                      children: <Widget>[
                        DividerWithText(
                          dividerText: 'Vorschläge',
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _suggestedList.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return _buildDeleteSuggestion();
                              } else {
                                return _buildSuggestion(
                                    _suggestedList[index - 1]);
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// deleteSuggestions()

  Widget _buildDeleteSuggestion() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Letzte Suchen',
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w300,
                color: Theme.of(context).primaryColor,
                letterSpacing: 1.2),
          ),
          GestureDetector(
            onTap: () => deleteSuggestions(),
            child: Text(
              'Löschen',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w300,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestion(query) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _searchController.text = query;
        });
        initiateSearch(query);
      },
      child: Container(
        height: 0.075 * MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.2,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  query,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                      color: Theme.of(context).primaryColor,
                      letterSpacing: 1.2),
                ),
              ),
              Icon(
                Ionicons.ios_arrow_forward,
                size: 24.0,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
