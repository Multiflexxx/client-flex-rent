import 'dart:developer';

import 'package:flexrent/logic/blocs/authentication/authentication.dart';
import 'package:flexrent/screens/authentication/login/login.dart';
import 'package:flexrent/screens/authentication/registration/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationScreen extends StatelessWidget {
  final String popRouteName;
  final Widget targetScreen;
  final VoidCallback hideNavBarFunction;

  AuthenticationScreen(
      {this.popRouteName, this.targetScreen, this.hideNavBarFunction});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationAuthenticated) {
          hideNavBarFunction();
          Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(
              builder: (BuildContext context) {
                return targetScreen;
              },
            ),
            ModalRoute.withName(popRouteName),
          );
        }
        if (state is AuthenticationCanceld) {
          hideNavBarFunction();
          Navigator.of(context).popUntil(
            ModalRoute.withName(popRouteName),
          );
          BlocProvider.of<AuthenticationBloc>(context).add(UserSignIn());
        }
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationSignUp) {
            return RegisterScreen();
          }
          return LoginScreen();
        },
      ),
    );
  }
}
