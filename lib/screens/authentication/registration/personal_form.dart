import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rent/logic/blocs/authentication/authentication.dart';
import 'package:rent/logic/blocs/register/bloc/register_bloc.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/widgets/formfieldstyled.dart';

class PersonalForm extends StatefulWidget {
  final String phoneNumber;

  PersonalForm({this.phoneNumber});

  @override
  _PersonalFormState createState() => _PersonalFormState();
}

class _PersonalFormState extends State<PersonalForm> {
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
      hintText: "Vorname",
      validator: (String value) {
        if (value.isEmpty) {
          return 'Vorname notwendig';
        }
      },
    );
  }

  Widget _buildNameField() {
    return FormFieldStyled(
      controller: _lastNameController,
      autocorrect: false,
      hintText: "Nachname",
      validator: (String value) {
        if (value.isEmpty) {
          return 'Nachname notwendig';
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
      hintText: "Email",
      type: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email notwendig';
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
      hintText: "Straße",
      validator: (String value) {
        if (value.isEmpty) {
          return 'Straße notwendig';
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
          return '';
        }
      },
    );
  }

  Widget _buildCityField() {
    return FormFieldStyled(
      controller: _cityController,
      autocorrect: false,
      hintText: "Stadt",
      validator: (String value) {
        if (value.isEmpty) {
          return 'Stadt notwendig';
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
          return 'PLZ notwendig';
        }
      },
    );
  }

  Widget _buildPasswordField() {
    return FormFieldStyled(
      controller: _passwordController,
      autocorrect: false,
      type: TextInputType.visiblePassword,
      icon: Icon(
        Icons.vpn_key,
        color: Colors.white,
      ),
      hintText: "Passwort",
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Passwort notwendig';
        }
      },
    );
  }

  Widget _buildPasswordAgainField() {
    return FormFieldStyled(
      controller: _verifiedPasswordController,
      autocorrect: false,
      type: TextInputType.visiblePassword,
      icon: Icon(
        Icons.vpn_key,
        color: Colors.white,
      ),
      obscureText: true,
      hintText: "Passwortverifizierung",
      validator: (String value) {
        if (value.isEmpty) {
          return '';
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _onRegisterSubmitPressed() {
      final f = new DateFormat('yyyy-MM-dd');

      User user = User(
        userId: '',
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        phoneNumber: widget.phoneNumber,
        // phoneNumber: '1234578699',
        passwordHash: _passwordController.text,
        verified: false,
        postCode: _zipController.text,
        city: _cityController.text,
        street: _streetController.text,
        houseNumber: _numberController.text,
        lesseeRating: 0,
        numberOfLesseeRatings: 0,
        lessorRating: 0,
        numberOfLessorRatings: 0,
        dateOfBirth: f.format(DateTime.now().subtract(Duration(days: 100))),
      );

      if (_key.currentState.validate()) {
        BlocProvider.of<RegisterBloc>(context)
            .add(RegisterSubmitPressed(user: user));
      } else {
        _autoValidate = true;
      }
    }

    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterPersonalFailure) {
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
          return Form(
            key: _key,
            autovalidate: _autoValidate,
            child: Flexible(
              fit: FlexFit.loose,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
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
                    _buildEMailField(),
                    SizedBox(
                      height: 10,
                    ),
                    _buildPasswordField(),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _buildPasswordAgainField(),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0)),
                      child: Text('Register'),
                      onPressed: state is RegisterLoading
                          ? () {}
                          : _onRegisterSubmitPressed,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Du hast noch kein Konto? ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                BlocProvider.of<RegisterBloc>(context)
                                    .add(RegisterPhoneForm());
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .add(UserSignIn());
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
