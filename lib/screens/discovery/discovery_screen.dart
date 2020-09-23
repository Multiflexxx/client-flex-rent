import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/logic/blocs/authentication/authentication.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/logic/models/offer/offer.dart';
import 'package:rent/logic/services/offer_service.dart';

import 'package:rent/widgets/discovery_carousel.dart';
import 'package:rent/widgets/search_bar.dart';

class DiscoveryScreen extends StatefulWidget {
  @override
  _DiscoveryScreen createState() => _DiscoveryScreen();
}

class _DiscoveryScreen extends State<DiscoveryScreen> {
  Future<Map<String, List<Offer>>> discoveryOffer;

  @override
  initState() {
    super.initState();
    discoveryOffer = ApiOfferService().getDiscoveryOffer();
  }

  // int _selectedIndex = 0;
  // List<IconData> _icons = [
  //   FontAwesome.laptop,
  //   Feather.smartphone,
  //   Feather.speaker,
  //   Feather.printer
  // ];

  // Widget _buildIcon(int index) {
  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         _selectedIndex = index;
  //       });
  //       print(_selectedIndex);
  //     },
  //     child: Container(
  //       height: 60.0,
  //       width: 60.0,
  //       decoration: BoxDecoration(
  //         color: _selectedIndex == index
  //             ? Theme.of(context).primaryColor
  //             : Colors.black,
  //         borderRadius: BorderRadius.circular(30.0),
  //       ),
  //       child: Icon(
  //         _icons[index],
  //         size: 25.0,
  //         color: _selectedIndex == index
  //             ? Colors.white
  //             : Theme.of(context).primaryColor,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<AuthenticationBloc>(context).state
        as AuthenticationAuthenticated;
    final User user = state.user;
    inspect(user);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            SearchBar(),
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 120.0),
              child: Text(
                'Hello ${user.firstName} ${user.lastName}',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20.0),

            // Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: _icons
            //         .asMap()
            //         .entries
            //         .map(
            //           (MapEntry map) => _buildIcon(map.key),
            //         )
            //         .toList()),

            FutureBuilder<Map<String, List<Offer>>>(
              future: discoveryOffer,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DiscoveryCarousel(
                    snapshot.data['bestOffer'],
                    'Topseller',
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            // FlatButton(
            //   child: Text('Test'),
            //   color: Colors.purple,
            //   onPressed: () => ApiOfferService().getDiscoveryOffer(),
            // ),
          ],
        ),
      ),
    );
  }
}
