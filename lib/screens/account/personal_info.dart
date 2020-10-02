import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/logic/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:rent/logic/models/user/user.dart';
import 'package:rent/widgets/formfieldstyled.dart';

class PersonalInfo extends StatefulWidget {
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final _formKey = GlobalKey<FormState>();
  User user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final state = BlocProvider.of<AuthenticationBloc>(context).state
    as AuthenticationAuthenticated;
    user = state.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meine Informationen"),
        centerTitle: true,
      ),
      body: Form(
          key: _formKey,
          child: ListView(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/images/jett.jpg'),
                          radius: 50.0,
                          child: Icon(Icons.edit, size: 40.0)
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child:
                          FormFieldStyled(
                            icon: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            hintText: 'Vorname',
                            type: TextInputType.name,
                            autocorrect: true,
                            initialValue: user.firstName,
                          ),
                      ),
                      Expanded(
                        child:
                        FormFieldStyled(
                          hintText: 'Nachname',
                          type: TextInputType.name,
                          autocorrect: true,
                          initialValue: user.lastName,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: FormFieldStyled(
                            icon: Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                            hintText: 'Strasse',
                            type: TextInputType.streetAddress,
                            autocorrect: true,
                            initialValue: user.street,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: FormFieldStyled(
                            hintText: 'Hausnummer',
                            autocorrect: true,
                            initialValue: user.houseNumber,
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: FormFieldStyled(
                          icon: Icon(
                            Icons.location_city,
                            color: Colors.white,
                          ),
                          hintText: 'PLZ',
                          type: TextInputType.number,
                          autocorrect: true,
                          initialValue: user.postCode,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: FormFieldStyled(
                          hintText: 'Ort',
                          autocorrect: true,
                          initialValue: user.city,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormFieldStyled(
                    icon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    hintText: 'E-Mail',
                    type: TextInputType.emailAddress,
                    autocorrect: true,
                    initialValue: user.email,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormFieldStyled(
                    icon: Icon(
                      Icons.vpn_key,
                      color: Colors.white,
                    ),
                    hintText: 'Passwort',
                    type: TextInputType.visiblePassword,
                    obscureText: true,
                    autocorrect: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormFieldStyled(
                    icon: Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    hintText: 'Handynummer',
                    type: TextInputType.phone,
                    autocorrect: true,
                    initialValue: user.phoneNumber,
                  ),
                ),
                FlatButton(
                  onPressed: null,
                  child: Text('Speichern', style: TextStyle(color: Colors.white),),
                )
              ])),
    );
  }
}
