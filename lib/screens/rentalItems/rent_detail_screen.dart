import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:rent/models/rent_product_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:rent/widgets/price/price_overview.dart';
import 'package:rent/widgets/price/price_tag.dart';
import 'package:intl/date_symbol_data_local.dart';



import 'package:syncfusion_flutter_datepicker/datepicker.dart' as _picker;




import 'package:flutter/cupertino.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';






class RentDetailScreen extends StatefulWidget {
  final RentProduct rentProduct;
  RentDetailScreen({this.rentProduct});

  @override
  _RentDetailScreen createState() => _RentDetailScreen();
}

class _RentDetailScreen extends State<RentDetailScreen> {
     DateTime _startDate;
  DateTime _endDate;

  @override
  void initState() {
    _startDate = null;
    _endDate = null;
      initializeDateFormatting('de_DE', null);
    super.initState();
  }
 void _onSelectedRangeChanged(_picker.PickerDateRange dateRange) {
    final DateTime startDateValue = dateRange.startDate;
    DateTime endDateValue = dateRange.endDate;
    endDateValue ??= startDateValue;
    setState(() {
      if (startDateValue.isAfter(endDateValue)) {
        _startDate = endDateValue;
        _endDate = startDateValue;
      } else {
        _startDate = startDateValue;
        _endDate = endDateValue;
      }
    });
  }


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
            leading: IconButton(
              icon: Icon(Feather.arrow_left),
              iconSize: 30.0,
              color: Colors.white,
              onPressed: () => Navigator.pop(context),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Feather.share),
                iconSize: 30.0,
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
              ),
            ],
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
                widget.rentProduct.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Hero(
                    tag: widget.rentProduct.offerId,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      child: Image(
                        image: AssetImage(widget.rentProduct.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                // Price tile
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(0xFF202020),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: [
                                PriceTag(widget.rentProduct.price),
                                GestureDetector(
                                  onTap: () => showCupertinoModalBottomSheet(
                                    expand: false,
                                    context: context,
                                    barrierColor: Colors.black45,
                                    builder: (context, scrollController) =>
                                        PriceOverview(
                                      price: widget.rentProduct.price,
                                      scrollController: scrollController,
                                      startDate: _startDate,
                                      endDate: _endDate,
                                    ),
                                  ),
                                  child: Text(
                                    'Preisübersicht',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     if (_startDate != null) {
                            //       Navigator.push(
                            //         context,
                            //         new CupertinoPageRoute(
                            //           builder: (BuildContext context) =>
                            //               new ConfirmationPaymentScreen(
                            //             offerRequest: OfferRequest(
                            //                 offer: widget.rentProduct,
                            //                 startDate: _startDate,
                            //                 endDate: _endDate),
                            //           ),
                            //         ),
                            //       );
                            //     } else {
                            //       Flushbar(
                            //         messageText: Text(
                            //           "Du musst einen Zeitraum auswählen.",
                            //           style: TextStyle(
                            //             color: Colors.white,
                            //             fontSize: 18.0,
                            //             letterSpacing: 1.2,
                            //           ),
                            //         ),
                            //         icon: Icon(
                            //           Icons.info_outline,
                            //           size: 28.0,
                            //           color: Colors.purple,
                            //         ),
                            //         duration: Duration(seconds: 3),
                            //         margin: EdgeInsets.all(10.0),
                            //         padding: EdgeInsets.all(16.0),
                            //         // flushbarPosition: FlushbarPosition.TOP,
                            //         borderRadius: 8,
                            //       )..show(context);
                            //     }
                            //   },
                            //   child: Container(
                            //     width: 0.4 * MediaQuery.of(context).size.width,
                            //     height: 50.0,
                            //     decoration: BoxDecoration(
                            //         color: Colors.purple,
                            //         borderRadius: BorderRadius.circular(10.0)),
                            //     child: Center(
                            //       child: Text(
                            //         'Reservieren',
                            //         style: TextStyle(
                            //             color: Colors.white,
                            //             fontSize: 20.0,
                            //             fontWeight: FontWeight.w300),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Description
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF202020),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AutoSizeText(
                      widget.rentProduct.description,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        height: 1.35,
                        fontWeight: FontWeight.w300,
                      ),
                      minFontSize: 16.0,
                      maxLines: 6,
                      overflowReplacement: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.rentProduct.description,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              height: 1.25,
                              fontWeight: FontWeight.w300,
                            ),
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          // GestureDetector(
                          //   onTap: () => showCupertinoModalBottomSheet(
                          //     expand: false,
                          //     context: context,
                          //     barrierColor: Colors.black45,
                          //     builder: (context, scrollController) =>
                          //         ProductDescription(
                          //       offer: widget.rentProduct,
                          //       scrollController: scrollController,
                          //     ),
                          //   ),
                          //   child: Text(
                          //     "Show more",
                          //     style: TextStyle(
                          //       color: Colors.purple,
                          //       fontSize: 16.0,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
                // Availabilty
                // GestureDetector(
                //   onTap: () async {
                //     final range = await showCupertinoModalBottomSheet<dynamic>(
                //       expand: true,
                //       context: context,
                //       barrierColor: Colors.black45,
                //       builder: (context, scrollController) => DateRangePicker(
                //         scrollController,
                //         date: null,
                //         range: _picker.PickerDateRange(
                //           _startDate,
                //           _endDate,
                //         ),
                //         minDate: DateTime.now(),
                //         maxDate: DateTime.now().add(
                //           Duration(days: 90),
                //         ),
                //         displayDate: _startDate,
                //       ),
                //     );
                //     if (range != null) {
                //       _onSelectedRangeChanged(range);
                //     }
                //   },
                //   child: Container(
                //     margin:
                //         EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
                //     padding: EdgeInsets.only(top: 8, bottom: 8),
                //     decoration: new BoxDecoration(
                //       color: Color(0xFF202020),
                //       borderRadius: BorderRadius.circular(10.0),
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.all(16.0),
                //       child: Row(
                //         children: [
                //           Expanded(
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Row(
                //                   children: [
                //                     Icon(
                //                       Feather.calendar,
                //                       color: Colors.purple,
                //                     ),
                //                     SizedBox(
                //                       width: 10.0,
                //                     ),
                //                     Text(
                //                       'Verfügbarkeit',
                //                       style: TextStyle(
                //                         color: Colors.white,
                //                         fontSize: 18.0,
                //                         height: 1.35,
                //                         fontWeight: FontWeight.w300,
                //                       ),
                //                       maxLines: 6,
                //                       overflow: TextOverflow.ellipsis,
                //                     ),
                //                   ],
                //                 ),
                //                 _startDate != null
                //                     ? Column(
                //                         children: [
                //                           SizedBox(
                //                             height: 10.0,
                //                           ),
                //                           Row(
                //                             children: [
                //                               Text(
                //                                 '${DateFormat('yMd', 'de').format(_startDate)}',
                //                                 style: TextStyle(
                //                                   color: Colors.white,
                //                                   fontSize: 16.0,
                //                                   height: 1.15,
                //                                   fontWeight: FontWeight.w300,
                //                                 ),
                //                               ),
                //                               _endDate != null &&
                //                                       _startDate != _endDate
                //                                   ? Text(
                //                                       ' bis ${DateFormat('yMd', 'de').format(_endDate)}',
                //                                       style: TextStyle(
                //                                         color: Colors.white,
                //                                         fontSize: 16.0,
                //                                         height: 1.15,
                //                                         fontWeight:
                //                                             FontWeight.w300,
                //                                       ),
                //                                     )
                //                                   : Container(),
                //                             ],
                //                           ),
                //                         ],
                //                       )
                //                     : Container(),
                //               ],
                //             ),
                //           ),
                //           Icon(
                //             Ionicons.ios_arrow_forward,
                //             size: 30.0,
                //             color: Colors.white70,
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),

                // User
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF202020),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Vermieter/in: Tristan',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    height: 1.35,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  'Flexer seit August 2020',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image(
                                width: 75,
                                height: 75,
                                image: AssetImage('assets/images/jett.jpg'),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.purple,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              '69 Bewertungen',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                height: 1.35,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        // Verification
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.verified_user,
                              color: Colors.purple,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'Identität verifiziert',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                height: 1.35,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              print('kontaktieren');
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50.0,
                              decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Center(
                                child: Text(
                                  'Vermieter kontaktieren',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                //Bewertung 
                Container(
                   margin:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF202020),
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Deine Bewertung:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            height: 1.34,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                          SizedBox(
                          height: 10.0,
                        ),
                        // StarRating(widget.rentProduct.stars),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.purple,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                              Icon(
                              Icons.star,
                              color: Colors.purple,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                              Icon(
                              Icons.star,
                              color: Colors.purple,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                              Icon(
                              Icons.star,
                              color: Colors.purple,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                              Icon(
                              Icons.star,
                              color: Colors.white,
                            ),
                          
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        // Verification
                        Text( 
                          widget.rentProduct.rating == '' ?  'Bewerte das Produkt' : widget.rentProduct.rating,
                          style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        height: 1.35,
                        fontWeight: FontWeight.w300,
                      ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              print('Ändern');
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50.0,
                              decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Center(
                                child: Text(
                                  'Bewertung Anpassen',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}