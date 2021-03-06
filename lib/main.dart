import 'package:flexrent/logic/blocs/offer/bloc/offer_bloc.dart';
import 'package:flexrent/logic/ticker/ticker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flexrent/app.dart';
import 'package:flexrent/logic/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:flexrent/logic/blocs/user/bloc/user_bloc.dart';
import 'package:flexrent/logic/blocs/chat/chat.dart';

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
            RepositoryProvider<GoogleService>(
              create: (context) => ApiGoogleService(),
            ),
            RepositoryProvider<FacebookService>(
              create: (context) => ApiFacebookService(),
            ),
            RepositoryProvider<ChatService>(
              create: (context) => ApiChatService(),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AuthenticationBloc>(
                create: (context) {
                  final authService =
                      RepositoryProvider.of<AuthenticationService>(context);
                  final googleService =
                      RepositoryProvider.of<GoogleService>(context);
                  return AuthenticationBloc(
                    authService,
                    googleService,
                  )..add(AppLoaded());
                },
              ),
              BlocProvider<UserBloc>(
                create: (context) {
                  final userService =
                      RepositoryProvider.of<UserService>(context);
                  return UserBloc(BlocProvider.of<AuthenticationBloc>(context),
                      userService);
                },
              ),
              BlocProvider<OfferBloc>(
                lazy: false,
                create: (context) {
                  return OfferBloc(Ticker());
                },
              ),
              BlocProvider<ChatBloc>(
                  lazy: false,
                  create: (context) {
                    final chatService =
                        RepositoryProvider.of<ChatService>(context);
                    return ChatBloc(Ticker(), chatService);
                  })
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
      home: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationAuthenticated) {
            BlocProvider.of<OfferBloc>(context).add(OfferTickerStarted());
            BlocProvider.of<ChatBloc>(context)
                .add(ChatOverviewTickerStarted(page: 1));
          }
        },
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return App(
              key: appKey,
            );
          },
        ),
      ),
    );
  }
}
