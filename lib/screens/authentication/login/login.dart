import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/logic/blocs/authentication/authentication.dart';
import 'package:rent/logic/blocs/login/login.dart';
import 'package:rent/logic/services/services.dart';
import 'package:rent/screens/authentication/login/sign_in_form.dart';
import 'package:rent/widgets/background/logo.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: UniqueKey(),
      body: Stack(children: <Widget>[
        Background(top: 30),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            minimum: const EdgeInsets.all(16),
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is AuthenticationNotAuthenticated ||
                    state is AuthenticationSignIn) {
                  return _AuthForm();
                }
                if (state is AuthenticationFailure) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(state.message),
                      FlatButton(
                        textColor: Theme.of(context).accentColor,
                        child: Text('Retry'),
                        onPressed: () {
                          BlocProvider.of<AuthenticationBloc>(context)
                              .add(AppLoaded());
                        },
                      )
                    ],
                  ));
                }
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              },
            ),
          ),
        ),
      ]),
    );
  }
}

class _AuthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = RepositoryProvider.of<AuthenticationService>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Login',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 50,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
                BlocProvider.of<AuthenticationBloc>(context), authService),
            child: SignInForm(),
          ),
        ),
      ],
    );
  }
}
