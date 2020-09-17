import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rent/login/register.dart';
import 'package:rent/widgets/formfieldstyled.dart';

class PhoneScreen extends StatefulWidget {
  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
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
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.all(20),
            height: 380,
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Hier kann das Logo und ein Text hin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
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
                      Navigator.push(
                        context,
                        new CupertinoPageRoute(
                          builder: (BuildContext context) {
                            return RegisterScreen();
                          },
                        ),
                      );
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
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
                              }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
