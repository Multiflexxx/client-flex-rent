import 'package:flexrent/logic/blocs/authentication/authentication.dart';
import 'package:flexrent/logic/blocs/register/register.dart';
import 'package:flexrent/widgets/styles/buttons_styles/button_purple_styled.dart';
import 'package:flexrent/widgets/styles/divider_with_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

class RegisterStartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Column(
          children: <Widget>[
            PurpleButton(
              text: Text('Erstelle einen FlexRent Account'),
              onPressed: () {
                BlocProvider.of<RegisterBloc>(context)
                    .add(RegisterPhoneForm(signUpOption: 'email'));
              },
            ),
            SizedBox(
              height: 30.0,
            ),
            DividerWithText(
              dividerText: 'Registrieren mit',
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
                    BlocProvider.of<RegisterBloc>(context)
                        .add(RegisterWithGoogle(signUpOption: 'google'));
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
                    BlocProvider.of<RegisterBloc>(context)
                        .add(RegisterWithFacebook(signUpOption: 'facebook'));
                  },
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            RichText(
              text: TextSpan(
                text: 'Du hast schon ein FlexRent Konto? ',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Einloggen',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(UserSignIn());
                      },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
