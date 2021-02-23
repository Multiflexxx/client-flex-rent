import 'package:flexrent/logic/blocs/authentication/authentication.dart';
import 'package:flexrent/logic/blocs/password_reset/bloc/password_reset_bloc.dart';
import 'package:flexrent/logic/services/services.dart';
import 'package:flexrent/screens/authentication/password_reset/password_reset_code_form.dart';
import 'package:flexrent/screens/authentication/password_reset/password_reset_email_form.dart';
import 'package:flexrent/screens/authentication/password_reset/password_reset_password_form.dart';
import 'package:flexrent/widgets/background/logo.dart';
import 'package:flexrent/widgets/styles/flushbar_styled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

class PasswordReset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Feather.x,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: <Widget>[
            Background(top: 30),
            SafeArea(
              minimum: const EdgeInsets.all(16),
              child: BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is AuthenticationAuthenticated) {
                    Navigator.of(context).pop();
                  }
                },
                child: _AuthForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authenticationService =
        RepositoryProvider.of<AuthenticationService>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password zurücksetzen',
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 42,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2),
        ),
        BlocProvider<PasswordResetBloc>(
          create: (context) => PasswordResetBloc(
            BlocProvider.of<AuthenticationBloc>(context),
            authenticationService,
          ),
          child: BlocListener<PasswordResetBloc, PasswordResetState>(
            listener: (context, state) {
              if (state is PasswordResetFailure ||
                  state is PasswordResetEmailFailure ||
                  state is PasswordResetCodeFailure) {
                showFlushbar(context: context, message: state.error);
              }
            },
            child: BlocBuilder<PasswordResetBloc, PasswordResetState>(
              builder: (context, state) {
                if (state is PasswordResetRequestSuccess ||
                    state is PasswordResetCodeFailure) {
                  return PasswordResetCodeForm(email: state.email);
                }
                if (state is PasswordResetCodeSuccess) {
                  return PasswordResetPasswordForm(
                    email: state.email,
                    token: state.token,
                  );
                }
                if (state is PasswordResetLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return PasswordResetEmailForm();
              },
            ),
          ),
        ),
      ],
    );
  }
}
