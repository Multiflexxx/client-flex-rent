import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/logic/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:rent/logic/models/user/user.dart';
import 'package:rent/logic/services/services.dart';
import 'package:rent/screens/account/settings/update_password.dart';
import 'package:rent/widgets/formfieldstyled.dart';

class PersonalInfo extends StatefulWidget {
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final _key = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _streetController = TextEditingController();
  final _numberController = TextEditingController();
  final _zipController = TextEditingController();
  final _cityController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  User user;

  @override
  void initState() {
    super.initState();
    final state = BlocProvider.of<AuthenticationBloc>(context).state
        as AuthenticationAuthenticated;
    user = state.user;

    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    _streetController.text = user.street;
    _numberController.text = user.houseNumber;
    _zipController.text = user.postCode;
    _cityController.text = user.city;
    _emailController.text = user.email;
    _phoneController.text = user.phoneNumber;
  }

  void _saveChanges() {
    if (_key.currentState.validate()) {
      User _updatedUser = User(
        userId: user.userId,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        phoneNumber: _phoneController.text,
        verified: user.verified,
        postCode: _zipController.text,
        city: _cityController.text,
        street: _streetController.text,
        houseNumber: _numberController.text,
        lesseeRating: user.lesseeRating,
        numberOfLesseeRatings: user.numberOfLesseeRatings,
        lessorRating: user.lessorRating,
        numberOfLessorRatings: user.numberOfLessorRatings,
        dateOfBirth: user.dateOfBirth,
      );
      // BlocProvider.of<AuthenticationBloc>(context)
      //     .add(UserUpdate(user: _updatedUser));
      ApiUserService().updateUser(user: _updatedUser);
    } else {
      print('falsch');
    }
  }

  void _updatePassword() async {
    final response = await pushNewScreen(context,
        screen: UpdatePasswordScreen(), withNavBar: true);
    if (response == 'success') {
      Flushbar(
        messageText: Text(
          'Passwort wurde erfolgreich geändert',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            letterSpacing: 1.2,
          ),
        ),
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.purple,
        ),
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(16.0),
        borderRadius: 8,
      )..show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meine Informationen"),
        centerTitle: true,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
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
                                      backgroundImage:
                                          AssetImage('assets/images/jett.jpg'),
                                      radius: 50.0,
                                      child: Icon(Icons.edit, size: 40.0)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: FormFieldStyled(
                                  controller: _firstNameController,
                                  icon: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                  hintText: 'Vorname',
                                  type: TextInputType.name,
                                  autocorrect: true,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Vorname notwendig';
                                    }
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: FormFieldStyled(
                                  controller: _lastNameController,
                                  hintText: 'Nachname',
                                  type: TextInputType.name,
                                  autocorrect: true,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Nachname notwendig';
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: FormFieldStyled(
                                  controller: _streetController,
                                  icon: Icon(
                                    Icons.home,
                                    color: Colors.white,
                                  ),
                                  hintText: 'Straße',
                                  type: TextInputType.streetAddress,
                                  autocorrect: true,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Straße notwendig';
                                    }
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: FormFieldStyled(
                                  controller: _numberController,
                                  hintText: 'Hausnummer',
                                  autocorrect: true,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Hausnummer notwendig';
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: FormFieldStyled(
                                  controller: _zipController,
                                  icon: Icon(
                                    Icons.location_city,
                                    color: Colors.white,
                                  ),
                                  hintText: 'PLZ',
                                  type: TextInputType.number,
                                  autocorrect: true,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'PLZ notwendig';
                                    }
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                flex: 2,
                                child: FormFieldStyled(
                                  controller: _cityController,
                                  hintText: 'Ort',
                                  autocorrect: true,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Ort notwendig';
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FormFieldStyled(
                            controller: _emailController,
                            icon: Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                            hintText: 'E-Mail',
                            type: TextInputType.emailAddress,
                            autocorrect: true,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'E-Mail notwendig';
                              }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // FormFieldStyled(
                          //   icon: Icon(
                          //     Icons.vpn_key,
                          //     color: Colors.white,
                          //   ),
                          //   hintText: 'Passwort',
                          //   type: TextInputType.visiblePassword,
                          //   obscureText: true,
                          //   autocorrect: true,
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          FormFieldStyled(
                            controller: _phoneController,
                            icon: Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            hintText: 'Handynummer',
                            type: TextInputType.phone,
                            autocorrect: true,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Handynummer notwendig';
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
                            onPressed: () => _saveChanges(),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          RaisedButton(
                            color: Colors.transparent,
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(16),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(8.0),
                                side: BorderSide(
                                    color: Colors.purple, width: 1.75)),
                            child: Text('Passwort ändern'),
                            onPressed: () => _updatePassword(),
                          ),
                        ],
                      ),
                    ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
