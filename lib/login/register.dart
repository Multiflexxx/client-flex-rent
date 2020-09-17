import 'package:flutter/material.dart';

import 'formfield.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key key}) : super(key: key);

  Widget _buildFirstNameField() {
    return FormFieldStyled(
      icon: Icon(
        Icons.person,
        color: Colors.white,
      ),
      hintText: "Enter your Firstname",
      validator: (String value) {
        if (value.isEmpty) {
          return 'Your Password is required';
        } else if (!RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$")
            .hasMatch(value)) {
          return 'Please use a valid name';
        }
      },
    );
  }

  Widget _buildNameField() {
    return FormFieldStyled(
      hintText: "Enter your Name",
      validator: (String value) {
        if (value.isEmpty) {
          return 'Your Password is required';
        } else if (!RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$")
            .hasMatch(value)) {
          return 'Please use a valid name';
        }
      },
    );
  }

  Widget _buildEMailField() {
    return FormFieldStyled(
      icon: Icon(
        Icons.email,
        color: Colors.white,
      ),
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
    );
  }

  Widget _buildStreetField() {
    return FormFieldStyled(
      icon: Icon(
        Icons.location_city,
        color: Colors.white,
      ),
      hintText: "Enter your Street",
      validator: (String value) {
        if (value.isEmpty) {
          return 'A Street is required';
        } else if (!RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$")
            .hasMatch(value)) {}
      },
    );
  }

  Widget _buildHouseNrField() {
    return FormFieldStyled(
      hintText: "Nr.",
      validator: (String value) {
        if (value.isEmpty) {
          return 'A House number is required';
        }
      },
    );
  }

  Widget _buildCityField() {
    return FormFieldStyled(
      hintText: "City",
      validator: (String value) {
        if (value.isEmpty) {
          return 'A City is required';
        } else if (!RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$")
            .hasMatch(value)) {
          return 'Your Password needs 8 Characters';
        }
      },
    );
  }

  Widget _buildPlzField() {
    return FormFieldStyled(
      icon: Icon(
        Icons.location_city,
        color: Colors.white,
      ),
      hintText: "PLZ",
      length: 5,
      type: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'A PLZ is required';
        } else if (!RegExp(r"^([0]{1}[1-9]{1}|[1-9]{1}[0-9]{1})[0-9]{3}$")
            .hasMatch(value)) {
          return 'Your Password needs 8 Characters';
        }
      },
    );
  }

  Widget _buildPasswordField() {
    return FormFieldStyled(
      icon: Icon(
        Icons.vpn_key,
        color: Colors.white,
      ),
      hintText: "Enter a Password",
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Your Password is required';
        } else if (!RegExp(r"^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$")
            .hasMatch(value)) {
          return 'Please use a valid Password';
        }
      },
    );
  }

  Widget _buildPasswordAgainField() {
    return FormFieldStyled(
      icon: Icon(
        Icons.vpn_key,
        color: Colors.white,
      ),
      obscureText: true,
      helperText:
          "The Password must contain at least one letter, one number and be longer than six.",
      hintText: "Enter the Password again",
      validator: (String value) {
        if (value.isEmpty) {
          return 'Your Password is required';
        } else if (!RegExp(r"^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$")
            .hasMatch(value)) {
          return 'Please use a valid Password';
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Align(
        alignment: Alignment.center,
        child: Form(
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              Text(
                'Logo von FlexRent',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(flex: 3, child: _buildFirstNameField()),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(flex: 2, child: _buildNameField()),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              _buildEMailField(),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(flex: 3, child: _buildStreetField()),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(flex: 1, child: _buildHouseNrField()),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(flex: 2, child: _buildPlzField()),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(flex: 3, child: _buildCityField()),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              _buildPasswordField(),
              SizedBox(
                height: 10,
              ),
              _buildPasswordAgainField(),
              SizedBox(
                height: 10,
              ),
              FlatButton(
                child: Text('Login'),
                color: Colors.purple,
                textColor: Colors.white,
                padding: EdgeInsets.all(18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    ));
  }
}
