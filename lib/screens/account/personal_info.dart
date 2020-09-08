import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent/widgets/formfieldstyled.dart';

class PersonalInfo extends StatefulWidget {
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final _formKey = GlobalKey<FormState>();

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
                          //child: Text('JJ'),
                        ),
                        FlatButton(
                          onPressed: null,
                          child: Text(
                            'Edit',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormFieldStyled(
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    hintText: 'Name',
                    type: TextInputType.name,
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
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: FormFieldStyled(
                            hintText: 'Hausnummer',
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
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: FormFieldStyled(
                          hintText: 'Ort',
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
