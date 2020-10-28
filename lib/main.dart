import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flexrent/app.dart';
import 'package:flexrent/logic/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:flexrent/logic/blocs/user/bloc/user_bloc.dart';
import 'package:flexrent/screens/authentication/login/login.dart';
import 'package:flexrent/screens/authentication/registration/register.dart';

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
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AuthenticationBloc>(
                create: (context) {
                  final authService =
                      RepositoryProvider.of<AuthenticationService>(context);
                  return AuthenticationBloc(
                    authService,
                  )..add(AppLoaded());
                },
              ),
              BlocProvider<UserBloc>(create: (context) {
                final userService = RepositoryProvider.of<UserService>(context);
                return UserBloc(
                    BlocProvider.of<AuthenticationBloc>(context), userService);
              }),
            ],
            child: MyApp(),
          )),
    );

class MyApp extends StatelessWidget {
  static final appKey = new GlobalKey<AppState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlexRent',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.purple,
        backgroundColor: Color(0xFFDBD7DB),
        cardColor: Color(0xFFE9E9E9),
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black),
        ),
        scaffoldBackgroundColor: Color(0xFFDBD7DB),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.purple,
        backgroundColor: Colors.black,
        cardColor: Color(0xFF202020),
        iconTheme: IconThemeData(color: Colors.white),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.white),
        ),
        scaffoldBackgroundColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return App(
              key: appKey,
            );
          }
          // if (state is AuthenticationSignUp) {
          return AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.25),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
              child: state is AuthenticationSignUp
                  ? RegisterScreen()
                  : LoginScreen());
          // }
          // return LoginScreen();
        },
      ),
    );
  }
}
