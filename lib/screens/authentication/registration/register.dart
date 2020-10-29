import 'package:flexrent/logic/services/services.dart';
import 'package:flexrent/screens/authentication/registration/phone_form.dart';
import 'package:flexrent/screens/authentication/registration/register_start_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flexrent/logic/blocs/authentication/authentication.dart';
import 'package:flexrent/logic/blocs/register/register.dart';
import 'package:flexrent/screens/authentication/registration/personal_form.dart';
import 'package:flexrent/widgets/background/logo.dart';

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
    final googleService = RepositoryProvider.of<GoogleService>(context);
    final facebookService = RepositoryProvider.of<FacebookService>(context);

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
            BlocProvider.of<AuthenticationBloc>(context),
            registerService,
            googleService,
            facebookService,
          ),
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              if (state is RegisterPhoneLoading) {
                return PhoneForm();
              }
              if (state is RegisterPhoneSuccess) {
                return PersonalForm(
                  phoneNumber: state.phoneNumber,
                  thirdPartyUser: state.thirdPartyUser,
                );
              }
              // else if (state is RegisterPersonalLoading) {
              //   return PersonalForm(
              //     phoneNumber: state.phoneNumber,
              //     thirdPartyUser: state.thirdPartyUser,
              //   );
              // }
              return RegisterStartScreen();
            },
          ),
        ),
      ],
    );
  }
}
