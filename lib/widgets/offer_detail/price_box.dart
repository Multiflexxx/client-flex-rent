// import 'package:flutter/material.dart';
// import 'package:flushbar/flushbar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:rent/widgets/price/price_tag.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import 'package:rent/widgets/price/price_overview.dart';
// import 'package:rent/screens/booking/confiramtion_payment_screen.dart';
// import 'package:rent/models/offer_request_model.dart';


// class DescriptionBox extends StatelessWidget {
//   final price;
//  final startDate;
//  final endDate;
//   DescriptionBox({this.price, this.startDate, this.endDate});

//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//                   margin:
//                       EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
//                   height: 80,
//                   decoration: BoxDecoration(
//                     color: Color(0xFF202020),
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Column(
//                               children: [
//                                 PriceTag(price),
//                                 GestureDetector(
//                                   onTap: () => showCupertinoModalBottomSheet(
//                                     expand: false,
//                                     context: context,
//                                     barrierColor: Colors.black45,
//                                     builder: (context, scrollController) =>
//                                         PriceOverview(
//                                       price: price,
//                                       scrollController: scrollController,
//                                       startDate: startDate,
//                                       endDate: endDate,
//                                     ),
//                                   ),
//                                   child: Text(
//                                     'Preisübersicht',
//                                     style: TextStyle(
//                                       color: Colors.white70,
//                                       fontSize: 14.0,
//                                       fontWeight: FontWeight.w300,
//                                       decoration: TextDecoration.underline,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 if (startDate != null) {
//                                   Navigator.push(
//                                     context,
//                                     new CupertinoPageRoute(
//                                       builder: (BuildContext context) =>
//                                           new ConfirmationPaymentScreen(
//                                         offerRequest: OfferRequest(
//                                             offer: offer,
//                                             startDate: startDate,
//                                             endDate: endDate),
//                                       ),
//                                     ),
//                                   );
//                                 } else {
//                                   Flushbar(
//                                     messageText: Text(
//                                       "Du musst einen Zeitraum auswählen.",
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 18.0,
//                                         letterSpacing: 1.2,
//                                       ),
//                                     ),
//                                     icon: Icon(
//                                       Icons.info_outline,
//                                       size: 28.0,
//                                       color: Colors.purple,
//                                     ),
//                                     duration: Duration(seconds: 3),
//                                     margin: EdgeInsets.all(10.0),
//                                     padding: EdgeInsets.all(16.0),
//                                     // flushbarPosition: FlushbarPosition.TOP,
//                                     borderRadius: 8,
//                                   )..show(context);
//                                 }
//                               },
//                               child: Container(
//                                 width: 0.4 * MediaQuery.of(context).size.width,
//                                 height: 50.0,
//                                 decoration: BoxDecoration(
//                                     color: Colors.purple,
//                                     borderRadius: BorderRadius.circular(10.0)),
//                                 child: Center(
//                                   child: Text(
//                                     'Reservieren',
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 20.0,
//                                         fontWeight: FontWeight.w300),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//   }
// }
