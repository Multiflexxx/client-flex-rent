// import 'dart:html';

import 'package:flutter/material.dart';
import 'formfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Login")),
        body: Align(
          alignment: Alignment.center,
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Logo von FlexRent',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2),
                  ),

                  Container(
                    child: Column(
                      children: [
                        FormFieldStyled(
                          hintText: "Enter your Emailaddress",
                          type: TextInputType.emailAddress,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'A Email is required';
                            } else if (!RegExp(
                                    r"(^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$)")
                                .hasMatch(value)) {
                              return 'Please use a valid email';
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        FormFieldStyled(
                          hintText: "Enter your Password",
                          obscureText: true,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Your Password is required';
                            } else if (!RegExp(
                                    r"^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$")
                                .hasMatch(value)) {
                              return 'Please use a valid Password';
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  //    TextFormField(
                  //     style: TextStyle(color: Colors.purple),
                  //     decoration: InputDecoration(
                  //       labelText: 'Name',
                  //       enabledBorder: UnderlineInputBorder(
                  //           borderSide: BorderSide(color: Colors.white)),
                  //       hintText: 'Enter your first name',
                  //       labelStyle: TextStyle(color: Colors.white),
                  //       hintStyle: TextStyle(color: Colors.white),
                  //       hoverColor: Colors.white,
                  //     ),
                  //     validator: (value) {
                  //       if (value.isEmpty) {
                  //         return 'Please enter some text';
                  //       }
                  //       return null;
                  //     },
                  //   ),

                  //   TextFormField(
                  //     style: TextStyle(color: Colors.purple),
                  //     decoration: InputDecoration(
                  //       labelText: 'Email',
                  //       enabledBorder: UnderlineInputBorder(
                  //           borderSide: BorderSide(color: Colors.white)),
                  //       hintText: 'Enter your Email',
                  //       labelStyle: TextStyle(color: Colors.white),
                  //       hintStyle: TextStyle(color: Colors.white),
                  //       hoverColor: Colors.white,
                  //     ),
                  //     validator: (value) {
                  //       if (value.isEmpty) {
                  //         return 'Please enter some text';
                  //       }
                  //       return null;
                  //     },

                  // ),

                  FlatButton(
                    child: Text('Login'),
                    color: Colors.purple,
                    textColor: Colors.white,
                    onPressed: () {},
                    padding: EdgeInsets.all(18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
