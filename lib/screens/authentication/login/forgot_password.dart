import 'package:flexrent/widgets/background/logo.dart';
import 'package:flexrent/widgets/styles/buttons_styles/button_purple_styled.dart';
import 'package:flexrent/widgets/styles/formfield_styled.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  var email_sent = false;

  void _resetPassword() async {
    if (_key.currentState.validate()) {
      final String _email = emailController.text;
      //BlocProvider.of<UserBloc>(context).add();
      setState(() {
        email_sent = true;
      });
    } else {
      print('falsch');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: Stack(children: <Widget>[
        Background(top: 30),
        SafeArea(
            minimum: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Passwort vergessen',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                    key: _key,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Flexible(
                        fit: FlexFit.loose,
                        child: SingleChildScrollView(
                            child: Column(children: <Widget>[
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
                            height: 12,
                          ),
                          PurpleButton(
                              text: Text('Passwort wiederherstellen'),
                              onPressed: () {
                                _resetPassword();
                              }),
                          SizedBox(
                            height: 15.0,
                          ),
                          email_sent
                              ? Text(
                                  "Bitte überprüfe Deine E-Mails, um Dein Passwort zurück zu setzen",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).primaryColor),
                                )
                              : Container(),
                        ]))))
              ],
            )),
      ]),
    );
  }
}
