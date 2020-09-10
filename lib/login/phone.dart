import 'package:flutter/material.dart';
import 'dropdown.dart';


// import 'package:dropdown_formfield/dropdown_formfield.dart';
class PhoneScreen extends StatelessWidget {
  PhoneScreen({Key key}) : super(key: key);
  bool checkBoxValue = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Phone")),
        body: Align(
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
                  //  TextFormField(
                  //    style: TextStyle(color: Colors.white),
                  //    decoration: InputDecoration(
                  //       suffix: DropdownButtonHideUnderline(child: DropdownButton(items: [
                  //         DropdownMenuItem(child: Text(''),
                  //         value: ''),
                  //          DropdownMenuItem(child: Text('+49'),
                  //         value: '+49'),
                  //          DropdownMenuItem(child: Text('+497'),
                  //         value: '+497'),

                  //       ], onChanged: (value){
                  //         setState((){
                  //           _value = value;
                  //         });
                  //       })),

                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(25.0),
                  //       ),
                  //       enabledBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.white),
                  //         borderRadius: BorderRadius.circular(25.0),
                  //       ),
                  //       errorBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.red),
                  //         borderRadius: BorderRadius.circular(25.0),
                  //       ),

                  //       labelStyle: TextStyle(color: Colors.white),
                  //       hintStyle: TextStyle(

                  //         color: Colors.white,
                  //       ),
                  //       hoverColor: Colors.white,
                  //    ),

                  //    ),
                  CustomDropDown(),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                          padding: EdgeInsets.fromLTRB(15, 13, 0, 0),
                          child: Text(
                            '+49',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )),
                      helperText:
                          'Wir werden dir eine SMS senden, um deine Nummer zu bestätigen. Es können übliche Gebühren für die Nachricht anfallen.',
                      helperStyle:
                          TextStyle(color: Colors.white60, height: 1.25),
                      helperMaxLines: 3,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      hintText: 'Enter your Phonenumber',
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      hoverColor: Colors.white,
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'A Phonenumber is required';
                      } else {
                        return 'Okay';
                      }
                    },
                    keyboardType: TextInputType.phone,
                  ),

                  Row(
                    children: [
                      Checkbox(
                        onChanged: (bool value) {
                          return true;
                        },
                        checkColor: Colors.white,
                        activeColor: Colors.purple,
                        value: checkBoxValue,
                      ),
                      Text('Ich akzeptiere die Nutzungsbedingungen')
                    ],
                  ),
                  Row(
                    children: [
                      Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.white),
                        child: Checkbox(
                          onChanged: (bool value) {
                            return false;
                          },
                          checkColor: Colors.purple,
                          activeColor: Colors.white,
                          value: false,
                          hoverColor: Colors.white,
                        ),
                      ),
                      Text('Ich akzeptiere die AGB')
                    ],
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
                                  color: Colors.white))
                        ]),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
