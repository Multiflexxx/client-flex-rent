import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/logic/blocs/authentication/authentication.dart';
import 'package:rent/logic/blocs/user/user.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/widgets/flushbar_styled.dart';
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
      final Password _password = Password(
          oldPasswordHash: _oldPasswordController.text,
          newPasswordHash: _newPasswordController.text);
      BlocProvider.of<UserBloc>(context)
          .add(UserUpdate(user: user, password: _password));
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
          child: BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserSuccess) {
                showFlushbar(context: context, message: 'Passwort geändert');
              } else if (state is UserFailure) {
                showFlushbar(context: context, message: state.error);
              }
            },
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
                                        backgroundImage: AssetImage(
                                            'assets/images/jett.jpg'),
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
      ),
    );
  }
}
