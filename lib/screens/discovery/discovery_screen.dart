import 'package:flutter/material.dart';
import 'package:rent/models/product_model.dart';
import 'package:rent/widgets/discovery_carousel.dart';

class DiscoveryScreen extends StatefulWidget {
  final List<Product> productSuggestionList;

  DiscoveryScreen(this.productSuggestionList);

  @override
  _DiscoveryScreen createState() => _DiscoveryScreen();
}

class _DiscoveryScreen extends State<DiscoveryScreen> {
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
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 120.0),
              child: Text(
                'rent or rent?',
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
            // SizedBox(
            //   height: 20.0,
            // ),
            DiscoveryCarousel(
              widget.productSuggestionList,
              'Topseller',
            ),
            SizedBox(
              height: 20.0,
            ),
            DiscoveryCarousel(
              widget.productSuggestionList,
              'Suggestions for you',
            ),
            SizedBox(
              height: 20.0,
            ),
            DiscoveryCarousel(
              widget.productSuggestionList,
              'New shit',
            ),
          ],
        ),
      ),
    );
  }
}
