import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/app.dart';
import 'package:rent/logic/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:rent/screens/login/login.dart';

import 'logic/services/services.dart';

void main() => runApp(
      // Injects the Authentication service
      RepositoryProvider<AuthenticationService>(
        create: (context) {
          return ApiAuthenticationService();
        },
        // Injects the Authentication BLoC
        child: BlocProvider<AuthenticationBloc>(
          create: (context) {
            final authService =
                RepositoryProvider.of<AuthenticationService>(context);
            return AuthenticationBloc(authService)..add(AppLoaded());
          },
          child: MyApp(),
        ),
      ),
    );

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
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return App();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
