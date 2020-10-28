import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flexrent/logic/blocs/authentication/authentication.dart';
import 'package:flexrent/logic/blocs/register/register.dart';
import 'package:flexrent/logic/services/register_service.dart';
import 'package:flexrent/screens/authentication/registration/personal_form.dart';
import 'package:flexrent/widgets/background/logo.dart';
import 'phone_form.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: UniqueKey(),
      body: Stack(children: <Widget>[
        Background(
          top: 30,
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            minimum: const EdgeInsets.all(16),
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is AuthenticationSignUp) {
                  return _AuthForm();
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
    final registerService = RepositoryProvider.of<RegisterService>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Register and become an User',
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 50,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(
              BlocProvider.of<AuthenticationBloc>(context), registerService),
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              if (state is RegisterPhoneSuccess) {
                return PersonalForm(phoneNumber: state.phoneNumber);
              } else if (state is RegisterPersonalLoading) {
                return PersonalForm(phoneNumber: state.phoneNumber);
              } else if (state is RegisterPersonalFailure) {
                return PersonalForm(phoneNumber: state.phoneNumber);
              }
              return PhoneForm();
            },
          ),
        ),
      ],
    );
  }
}
