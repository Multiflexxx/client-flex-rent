import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent/widgets/layout/standard_sliver_appbar_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/logic/blocs/authentication/authentication.dart';
import 'package:rent/logic/blocs/user/user.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/widgets/flushbar_styled.dart';
import 'package:rent/widgets/formfieldstyled.dart';

class UpdatePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StandardSliverAppBarList(
      title: 'Passwort ändern',
      // bodyWidget: Container(),
      bodyWidget: _UpdatePasswordBody(),
    );
  }
}

class _UpdatePasswordBody extends StatefulWidget {
  @override
  _UpdatePasswordBodyState createState() => _UpdatePasswordBodyState();
}

class _UpdatePasswordBodyState extends State<_UpdatePasswordBody> {
  final _key = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _verifiedPasswordController = TextEditingController();

  User _user;

  @override
  void initState() {
    super.initState();
    final state = BlocProvider.of<AuthenticationBloc>(context).state
        as AuthenticationAuthenticated;
    _user = state.user;
  }

  void _changePassword() async {
    if (_key.currentState.validate()) {
      final Password _password = Password(
          oldPasswordHash: _oldPasswordController.text,
          newPasswordHash: _newPasswordController.text);
      BlocProvider.of<UserBloc>(context)
          .add(UserUpdate(user: _user, password: _password));
    } else {
      print('falsch');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserSuccess) {
          showFlushbar(context: context, message: 'Passwort geändert');
        } else if (state is UserFailure) {
          showFlushbar(context: context, message: state.error);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        decoration: new BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Form(
          key: _key,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FormFieldStyled(
                controller: _oldPasswordController,
                icon: Icon(
                  Icons.vpn_key,
                  color: Theme.of(context).primaryColor,
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
              RaisedButton(
                color: Theme.of(context).accentColor,
                textColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.all(16),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8.0)),
                child: Text('Speichern'),
                onPressed: () => _changePassword(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
