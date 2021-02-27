import 'package:flexrent/logic/blocs/password_reset/password_reset.dart';
import 'package:flexrent/widgets/styles/buttons_styles/button_purple_styled.dart';
import 'package:flexrent/widgets/styles/formfield_styled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordResetEmailForm extends StatefulWidget {
  @override
  _PasswordResetEmailFormState createState() => _PasswordResetEmailFormState();
}

class _PasswordResetEmailFormState extends State<PasswordResetEmailForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final emailController = TextEditingController();

  void _resetPassword() async {
    if (_key.currentState.validate()) {
      final String _email = emailController.text;
      BlocProvider.of<PasswordResetBloc>(context)
          .add(PasswordResetSendRequest(email: _email));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Flexible(
        fit: FlexFit.loose,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FormFieldStyled(
                controller: emailController,
                autocorrect: false,
                hintText: 'Email',
                type: TextInputType.emailAddress,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Email ist notwendig';
                  } else if (!RegExp(
                          r"(^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$)")
                      .hasMatch(value)) {
                    return 'Bitte gebe eine gültige E-Mail Adresse ein';
                  }
                },
              ),
              SizedBox(
                height: 16,
              ),
              PurpleButton(
                text: Text('Passwort wiederherstellen'),
                onPressed: () {
                  _resetPassword();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
