import 'package:flexrent/widgets/styles/buttons_styles/button_purple_styled.dart';
import 'package:flexrent/widgets/styles/divider_with_text.dart';
import 'package:flexrent/widgets/styles/flushbar_styled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flexrent/logic/blocs/authentication/authentication.dart';
import 'package:flexrent/logic/blocs/login/login.dart';
import 'package:flexrent/widgets/styles/formfield_styled.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
          showFlushbar(context: context, message: state.error);
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
            child: Flexible(
              fit: FlexFit.loose,
              child: SingleChildScrollView(
                child: Column(
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
                    PurpleButton(
                      text: Text('Login'),
                      onPressed:
                          state is LoginLoading ? () {} : _onLoginButtonPressed,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    DividerWithText(
                      dividerText: 'Einloggen mit',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            Ionicons.logo_google,
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          ),
                          onPressed: () {
                            BlocProvider.of<LoginBloc>(context)
                                .add(LoginWithGoogleButtonPressed());
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Ionicons.logo_apple,
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          ),
                          onPressed: null,
                        ),
                        IconButton(
                          icon: Icon(
                            Ionicons.logo_facebook,
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          ),
                          onPressed: () {
                            BlocProvider.of<LoginBloc>(context)
                                .add(LoginWithFacebookButtonPressed());
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
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
            ),
          );
        },
      ),
    );
  }
}
