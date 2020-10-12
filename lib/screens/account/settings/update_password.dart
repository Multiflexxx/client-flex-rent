import 'dart:developer';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/logic/blocs/authentication/authentication.dart';
import 'package:rent/logic/exceptions/authentication_exception.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/logic/services/services.dart';
import 'package:rent/widgets/formfieldstyled.dart';

class UpdatePasswordScreen extends StatefulWidget {
  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _key = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _verifiedPasswordController = TextEditingController();

  User user;

  @override
  void initState() {
    super.initState();
    final state = BlocProvider.of<AuthenticationBloc>(context).state
        as AuthenticationAuthenticated;
    user = state.user;
  }

  void _changePassword() async {
    if (_key.currentState.validate()) {
      // BlocProvider.of<AuthenticationBloc>(context)
      //     .add(UserUpdate(user: _updatedUser));
      final Password _password = Password(
          oldPasswordHash: _oldPasswordController.text,
          newPasswordHash: _newPasswordController.text);
      try {
        await ApiUserService().updateUser(user: user, password: _password);
        Navigator.pop(context, 'success');
      } on AuthenticationException catch (e) {
        Flushbar(
          messageText: Text(
            e.message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              letterSpacing: 1.2,
            ),
          ),
          icon: Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.purple,
          ),
          duration: Duration(seconds: 3),
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(16.0),
          borderRadius: 8,
        )..show(context);
      } catch (err) {
        Flushbar(
          messageText: Text(
            'Da ist etwas schief gelaufen. Probiere es später nochmal.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              letterSpacing: 1.2,
            ),
          ),
          icon: Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.purple,
          ),
          duration: Duration(seconds: 3),
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(16.0),
          borderRadius: 8,
        )..show(context);
      }
    } else {
      print('falsch');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Passwort ändern"),
        centerTitle: true,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Column(
            children: [
              Flexible(
                child: Form(
                    key: _key,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/images/jett.jpg'),
                                      radius: 50.0,
                                      child: Icon(Icons.edit, size: 40.0)),
                                ],
                              ),
                            ),
                          ),
                          FormFieldStyled(
                            controller: _oldPasswordController,
                            icon: Icon(
                              Icons.vpn_key,
                              color: Colors.white,
                            ),
                            hintText: 'altes Passwort',
                            type: TextInputType.visiblePassword,
                            obscureText: true,
                            autocorrect: true,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'altes Passwort notwendig';
                              }
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          FormFieldStyled(
                            controller: _newPasswordController,
                            icon: Icon(
                              Icons.vpn_key,
                              color: Colors.white,
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
                              color: Colors.white,
                            ),
                            hintText: 'Passwort verifizieren',
                            type: TextInputType.visiblePassword,
                            obscureText: true,
                            autocorrect: true,
                            validator: (String value) {
                              if (value.isEmpty ||
                                  _newPasswordController.text != value) {
                                return 'Passwörter stimmen nicht überein';
                              }
                            },
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
                            child: Text('Speichern'),
                            onPressed: () => _changePassword(),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
