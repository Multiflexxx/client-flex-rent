import 'package:flexrent/logic/blocs/password_reset/password_reset.dart';
import 'package:flexrent/widgets/styles/buttons_styles/button_purple_styled.dart';
import 'package:flexrent/widgets/styles/formfield_styled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordResetPasswordForm extends StatefulWidget {
  final String email;
  final String token;

  const PasswordResetPasswordForm({Key key, this.email, this.token})
      : super(key: key);

  @override
  _PasswordResetPasswordFormState createState() =>
      _PasswordResetPasswordFormState();
}

class _PasswordResetPasswordFormState extends State<PasswordResetPasswordForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _verifiedPasswordController = TextEditingController();

  void _resetPassword() async {
    if (_key.currentState.validate()) {
      final String _password = _newPasswordController.text;
      BlocProvider.of<PasswordResetBloc>(context).add(
        PasswordResetSendNewPassword(
          email: widget.email,
          token: widget.token,
          password: _password,
        ),
      );
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
                controller: _newPasswordController,
                icon: Icon(
                  Icons.vpn_key,
                  color: Theme.of(context).primaryColor,
                ),
                hintText: 'neues Passwort',
                type: TextInputType.visiblePassword,
                obscureText: true,
                autocorrect: true,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'neues Passwort notwendig';
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              FormFieldStyled(
                controller: _verifiedPasswordController,
                icon: Icon(
                  Icons.vpn_key,
                  color: Theme.of(context).primaryColor,
                ),
                hintText: 'Passwort verifizieren',
                type: TextInputType.visiblePassword,
                obscureText: true,
                autocorrect: true,
                validator: (String value) {
                  if (value.isEmpty || _newPasswordController.text != value) {
                    return 'Passwörter stimmen nicht überein';
                  }
                },
              ),
              SizedBox(
                height: 16,
              ),
              PurpleButton(
                text: Text('Bestätigen'),
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
