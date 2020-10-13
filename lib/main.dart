import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/app.dart';
import 'package:rent/logic/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:rent/screens/authentication/login/login.dart';
import 'package:rent/screens/authentication/registration/register.dart';

import 'logic/services/services.dart';

void main() => runApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthenticationService>(
            create: (context) => ApiAuthenticationService(),
          ),
          RepositoryProvider<RegisterService>(
            create: (context) => ApiRegisterService(),
          ),
          RepositoryProvider<UserService>(
            create: (context) => ApiUserService(),
          ),
        ],
        child: BlocProvider<AuthenticationBloc>(
          create: (context) {
            final authService =
                RepositoryProvider.of<AuthenticationService>(context);
            final userService = RepositoryProvider.of<UserService>(context);
            return AuthenticationBloc(
              authService,
              userService,
            )..add(AppLoaded());
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
          } else if (state is AuthenticationSignUp) {
            return RegisterScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
