import 'package:flutter/material.dart';
import 'package:rent/app.dart';
import 'package:rent/screens/404.dart';
import 'package:rent/screens/account/account_screen.dart';
import 'package:rent/screens/account/personal_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flex Rent',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purple,
        accentColor: Color(0xFFD8ECF1),
        textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
        scaffoldBackgroundColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => App(),
        '/account' : (context) => AccountScreen(),
        '/personalInfo': (context) => PersonalInfo(),
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) => PageNotFound(),
        );
      },
    );
  }
}
