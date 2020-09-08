import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/jett.jpg'),
                    radius: 50.0,
                    //child: Text('JJ'),

                  )
                ],
              ),
              TextFormField(
                  decoration: const InputDecoration(
                icon: Icon(Icons.person, color: Colors.white,),
                hintText: 'Dein voller Name',
                labelText: 'Name *',
                    fillColor: Colors.white,
                    hoverColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.blueGrey),
              ))
            ]),
          )),
    );
  }
}
