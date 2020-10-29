import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flexrent/logic/blocs/authentication/authentication.dart';
import 'package:flexrent/logic/blocs/login/login.dart';
import 'package:flexrent/widgets/formfieldstyled.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      if (_key.currentState.validate()) {
        BlocProvider.of<LoginBloc>(context).add(LoginWithEmailButtonPressed(
            email: _emailController.text, password: _passwordController.text));
      }
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          _showError(state.error);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Form(
            key: _key,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  FormFieldStyled(
                    controller: _emailController,
                    autocorrect: false,
                    hintText: 'Email',
                    type: TextInputType.emailAddress,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Email ist notwendig';
                      } else if (!RegExp(
                              r"(^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$)")
                          .hasMatch(value)) {
                        return 'Bitte gebe eine gültige Nummer ein';
                      }
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  FormFieldStyled(
                    controller: _passwordController,
                    autocorrect: false,
                    hintText: 'Password',
                    obscureText: true,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Passwort ist notwendig.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    textColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.all(16),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(8.0)),
                    child: Text('Login'),
                    onPressed:
                        state is LoginLoading ? () {} : _onLoginButtonPressed,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Du hast noch kein Konto? ',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Registrieren',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .add(UserSignUp()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showError(String error) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(error),
      backgroundColor: Theme.of(context).errorColor,
    ));
  }
}
