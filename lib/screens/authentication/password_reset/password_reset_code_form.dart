import 'package:flexrent/logic/blocs/password_reset/password_reset.dart';
import 'package:flexrent/widgets/styles/buttons_styles/button_purple_styled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PasswordResetCodeForm extends StatefulWidget {
  final String email;

  const PasswordResetCodeForm({Key key, this.email}) : super(key: key);

  @override
  _PasswordResetCodeFormState createState() => _PasswordResetCodeFormState();
}

class _PasswordResetCodeFormState extends State<PasswordResetCodeForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  void _sendCode() async {
    if (_key.currentState.validate()) {
      final String _code = _codeController.text;
      BlocProvider.of<PasswordResetBloc>(context).add(
        PasswordResetSendCode(
          email: widget.email,
          code: _code,
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
              SizedBox(
                height: 12,
              ),
              Center(
                child: Container(
                  width: 0.75 * MediaQuery.of(context).size.width,
                  child: PinCodeTextField(
                      appContext: context,
                      length: 6,
                      animationType: AnimationType.fade,
                      backgroundColor: Colors.transparent,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        fieldHeight: 45.0,
                        fieldWidth: 35.0,
                        inactiveColor: Theme.of(context).primaryColor,
                        activeColor: Theme.of(context).primaryColor,
                        selectedColor: Theme.of(context).accentColor,
                      ),
                      textStyle: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColor,
                      ),
                      autovalidateMode: AutovalidateMode.disabled,
                      controller: _codeController,
                      validator: (v) {
                        if (v.length < 6) {
                          return 'Code ist notwendig';
                        } else {
                          return null;
                        }
                      },
                      textCapitalization: TextCapitalization.characters,
                      keyboardType: TextInputType.text,
                      onChanged: (String value) {
                        print(value);
                      },
                      onCompleted: (value) async {
                        _codeController.text = value;
                        await Future.delayed(Duration(milliseconds: 500));
                        _sendCode();
                      }),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              PurpleButton(
                text: Text('Bestätigen'),
                onPressed: () {
                  _sendCode();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
