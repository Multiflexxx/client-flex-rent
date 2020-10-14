import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/app.dart';
import 'package:rent/logic/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:rent/logic/blocs/user/bloc/user_bloc.dart';
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
