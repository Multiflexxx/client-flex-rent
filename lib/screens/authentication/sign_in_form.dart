import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/logic/blocs/login/login.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/widgets/formfieldstyled.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      if (_key.currentState.validate()) {
        BlocProvider.of<LoginBloc>(context).add(LoginInWithEmailButtonPressed(
            email: _emailController.text, password: _passwordController.text));
      } else {
        setState(() {
          _autoValidate = true;
        });
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
            autovalidate: _autoValidate,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  FormFieldStyled(
                    controller: _emailController,
                    autocorrect: false,
                    hintText: "Enter your Emailaddress",
                    type: TextInputType.emailAddress,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'A Email is required';
                      } else if (!RegExp(
                              r"(^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$)")
                          .hasMatch(value)) {
                        return 'Please use a valid email';
                      }
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  FormFieldStyled(
                    controller: _passwordController,
                    autocorrect: false,
                    hintText: "Enter your Password",
                    obscureText: true,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Password is required.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(8.0)),
                    child: Text('LOG IN'),
                    onPressed:
                        state is LoginLoading ? () {} : _onLoginButtonPressed,
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
