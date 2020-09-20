import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rent/logic/blocs/register/bloc/register_bloc.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/logic/services/register_service.dart';
import 'package:rent/widgets/formfieldstyled.dart';

class RegisterForm extends StatefulWidget {
  final String phoneNumber;

  RegisterForm({this.phoneNumber});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _streetController = TextEditingController();
  final _numberController = TextEditingController();
  final _zipController = TextEditingController();
  final _cityController = TextEditingController();
  final _passwordController = TextEditingController();
  final _verifiedPasswordController = TextEditingController();
  bool _autoValidate = false;

  Widget _buildFirstNameField() {
    return FormFieldStyled(
      controller: _firstNameController,
      autocorrect: false,
      icon: Icon(
        Icons.person,
        color: Colors.white,
      ),
      hintText: "Enter your Firstname",
      validator: (String value) {
        if (value.isEmpty) {
          return 'Is required';
        }
      },
    );
  }

  Widget _buildNameField() {
    return FormFieldStyled(
      controller: _lastNameController,
      autocorrect: false,
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
      controller: _emailController,
      autocorrect: false,
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
      controller: _streetController,
      autocorrect: false,
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
      controller: _numberController,
      autocorrect: false,
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
      controller: _cityController,
      autocorrect: false,
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
      controller: _zipController,
      autocorrect: false,
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
      controller: _passwordController,
      autocorrect: false,
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
      controller: _verifiedPasswordController,
      autocorrect: false,
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
    _onRegisterButtonPressed() {
      final f = new DateFormat('yyyy-MM-dd');
      User logUser = User(
        userId: '',
        firstName: 'Test',
        lastName: 'Test',
        email: 'test7@test.com',
        phoneNumber: '01234567896',
        passwordHash: 'test',
        verified: true,
        postCode: '68165',
        city: 'Mannheim',
        street: 'Wasserturm',
        houseNumber: '4',
        lesseeRating: 0,
        numberOfLesseeRatings: 0,
        lessorRating: 0,
        numberOfLessorRatings: 0,
        dateOfBirth: f.format(DateTime.now().subtract(Duration(days: 100))),
      );
      // if (_key.currentState.validate())
      BlocProvider.of<RegisterBloc>(context)
          .add(RegisterButtonPressed(user: logUser));
    }

    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailure) {
          _showError(state.error);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          if (state is RegisterLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Align(
            alignment: Alignment.center,
            child: Form(
              key: _key,
              autovalidate: _autoValidate,
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
                    child: Text('Register'),
                    color: Colors.purple,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    onPressed: () {
                      // User user = User(
                      //   userId: '',
                      //   firstName: _firstNameController.text,
                      //   lastName: _lastNameController.text,
                      //   email: _emailController.text,
                      //   phoneNumber: widget.phoneNumber,
                      //   passwordHash: _passwordController.text,
                      //   verified: false,
                      //   postCode: _zipController.text,
                      //   city: _cityController.text,
                      //   street: _streetController.text,
                      //   houseNumber: _numberController.text,
                      //   lesseeRating: 0,
                      //   numberOfLesseeRatings: 0,
                      //   lessorRating: 0,
                      //   numberOfLessorRatings: 0,
                      //   dateOfBirth: DateTime.now(),
                      // );
                      _onRegisterButtonPressed();
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showError(String error) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(error),
      backgroundColor: Theme.of(context).errorColor,
    ));
  }
}
