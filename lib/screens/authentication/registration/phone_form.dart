import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/logic/blocs/authentication/authentication.dart';
import 'package:rent/logic/blocs/register/register.dart';
import 'package:rent/screens/authentication/registration/personal_form.dart';
import 'package:rent/widgets/formfieldstyled.dart';

class PhoneForm extends StatefulWidget {
  @override
  _PhoneFormState createState() => _PhoneFormState();
}

class _PhoneFormState extends State<PhoneForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _autoValidate = false;
  bool _agbCheckBox;

  @override
  void initState() {
    super.initState();
    _agbCheckBox = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Form(
          key: _key,
          autovalidate: _autoValidate,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FormFieldStyled(
                controller: _phoneController,
                autocorrect: false,
                hintText: "Mobilenummer",
                helperText:
                    'Wir werden dir eine SMS senden, um deine Nummer zu bestätigen. Es können übliche Gebühren für die Nachricht anfallen.',
                type: TextInputType.phone,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Eine Mobilenummer ist notwendig';
                  } else {
                    return null;
                  }
                },
              ),
              Row(
                children: [
                  Theme(
                    data: ThemeData(unselectedWidgetColor: Colors.white),
                    child: Checkbox(
                      onChanged: (bool value) {
                        setState(() {
                          _agbCheckBox = value;
                        });
                      },
                      checkColor: Colors.purple,
                      activeColor: Colors.black,
                      value: _agbCheckBox,
                    ),
                  ),
                  Text('Ich akzeptiere die AGB')
                ],
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
                child: Text('Weiter'),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   new CupertinoPageRoute(
                  //     builder: (BuildContext context) {
                  //       return PersonalForm(
                  //         phoneNumber: _phoneController.text,
                  //       );
                  //     },
                  //   ),
                  // );
                  BlocProvider.of<RegisterBloc>(context)
                      .add(RegisterPersonalForm());
                },
              ),
              SizedBox(
                height: 16,
              ),
              RichText(
                text: TextSpan(
                  text: 'Du hast schon ein FlexRent Konto? ',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Einloggen',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
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
          ),
        );
      },
    );
  }
}
