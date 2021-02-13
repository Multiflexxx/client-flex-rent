import 'dart:developer';

import 'package:flexrent/logic/blocs/authentication/authentication.dart';
import 'package:flexrent/screens/authentication/login/login.dart';
import 'package:flexrent/screens/authentication/registration/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationScreen extends StatelessWidget {
  final String popRouteName;

  AuthenticationScreen({this.popRouteName});

  @override
  Widget build(BuildContext context) {
    inspect(popRouteName);
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationAuthenticated) {
          Navigator.of(context).popUntil(
            ModalRoute.withName(popRouteName),
          );
        }
        if (state is AuthenticationCanceld) {
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
