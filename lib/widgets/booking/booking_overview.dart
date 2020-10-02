import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/screens/booking/confiramtion_payment_screen.dart';
import 'package:rent/screens/booking/info_screen.dart';

class BookingOverview extends StatelessWidget {
  BookingOverview();
  int status = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(0xFF202020),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(Feather.calendar, color: Colors.purple),
                SizedBox(
                  width: 10.0,
                ),
                Text('Übersicht',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      height: 1.35,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ))
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Mietzeitraum',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      height: 1.0,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.2,
                    )),
                Text('30.09.2020 - 01.10.2020',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      height: 1.0,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.2,
                    ))
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Preis',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      height: 1.0,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.2,
                    )),
                Text('12 €',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      height: 1.0,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.2,
                    ))
              ],
            ),
            SizedBox(height: 20),
            status != 1
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: GestureDetector(
                          onTap: () => pushNewScreen(
                            context,
                            screen: ConfirmationPaymentScreen(),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            height: 50.0,
                            decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Center(
                              child: Text(
                                'Bearbeiten',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () => pushNewScreen(
                            context,
                            screen: InfoBookingScreen(),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            height: 50.0,
                            decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Center(
                              child: Text(
                                'Stornieren',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () => pushNewScreen(
                            context,
                            screen: InfoBookingScreen(),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            height: 50.0,
                            decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Center(
                              child: Text(
                                'Stornieren',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
