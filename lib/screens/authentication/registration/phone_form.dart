import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/logic/blocs/authentication/authentication.dart';
import 'package:rent/logic/blocs/register/register.dart';
import 'package:rent/widgets/formfieldstyled.dart';

class PhoneForm extends StatefulWidget {
  @override
  _PhoneFormState createState() => _PhoneFormState();
}

class _PhoneFormState extends State<PhoneForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _agbCheckBox;

  @override
  void initState() {
    super.initState();
    _agbCheckBox = false;
  }

  @override
  Widget build(BuildContext context) {
    _onNextPressed() {
      if (_key.currentState.validate() && _agbCheckBox == true) {
        BlocProvider.of<RegisterBloc>(context)
            .add(RegisterNextPressed(phoneNumber: _phoneController.text));
      }
    }

    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Form(
          key: _key,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Flexible(
            fit: FlexFit.loose,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  FormField<bool>(
                    builder: (field) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Theme(
                                data: ThemeData(
                                    unselectedWidgetColor:
                                        Theme.of(context).primaryColor),
                                child: Checkbox(
                                  checkColor: Colors.purple,
                                  activeColor:
                                      Theme.of(context).backgroundColor,
                                  value: _agbCheckBox,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _agbCheckBox = value;
                                      field.didChange(value);
                                    });
                                  },
                                ),
                              ),
                              Text('Ich akzeptiere die AGB'),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                              field.errorText ?? '',
                              style: TextStyle(
                                color: Theme.of(context).errorColor,
                                fontSize: 12.0,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    validator: (value) {
                      if (!_agbCheckBox) {
                        return 'Akzeptiere bitte unsere AGBs.';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    textColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.all(16),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(8.0)),
                    child: Text('Weiter'),
                    onPressed:
                        state is RegisterPhoneLoading ? () {} : _onNextPressed,
                  ),
                  SizedBox(
                    height: 16,
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
              ),
            ),
          ),
        );
      },
    );
  }
}
