import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/logic/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:rent/logic/blocs/user/bloc/user_bloc.dart';
import 'package:rent/logic/models/user/user.dart';
import 'package:rent/screens/account/settings/update_password_screen.dart';
import 'package:rent/widgets/camera/image_source.dart';
import 'package:rent/widgets/flushbar_styled.dart';
import 'package:rent/widgets/formfieldstyled.dart';
import 'package:rent/widgets/layout/standard_sliver_appbar_list.dart';

class PersonalInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StandardSliverAppBarList(
      title: 'Meine Informationen',
      bodyWidget: _PersonalInfoBody(),
    );
  }
}

class _PersonalInfoBody extends StatefulWidget {
  @override
  _PersonalInfoBodyState createState() => _PersonalInfoBodyState();
}

class _PersonalInfoBodyState extends State<_PersonalInfoBody> {
  final _key = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _streetController = TextEditingController();
  final _numberController = TextEditingController();
  final _zipController = TextEditingController();
  final _cityController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final picker = ImagePicker();

  User _user;
  Timer timer;
  File profileImage;

  @override
  void initState() {
    super.initState();
    _fetchUser();
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => _fetchUser());

    _firstNameController.text = _user.firstName;
    _lastNameController.text = _user.lastName;
    _streetController.text = _user.street;
    _numberController.text = _user.houseNumber;
    _zipController.text = _user.postCode;
    _cityController.text = _user.city;
    _emailController.text = _user.email;
    _phoneController.text = _user.phoneNumber;
  }

  void _fetchUser() {
    final state = BlocProvider.of<AuthenticationBloc>(context).state
        as AuthenticationAuthenticated;
    setState(() {
      _user = state.user;
    });
    inspect(_user);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _selectImageSource({BuildContext parentContext}) async {
    final ImageSource source = await showCupertinoModalBottomSheet(
      expand: false,
      useRootNavigator: true,
      context: context,
      barrierColor: Colors.black45,
      builder: (context, scrollController) => ImageSourcePicker(
        scrollController: scrollController,
      ),
    );
    _updateImage(source: source);
  }

  void _updateImage({ImageSource source}) async {
    final image = await picker.getImage(source: source);
    if (image != null) {
      final _image = File(image.path);
      setState(() {
        profileImage = _image;
      });
      BlocProvider.of<UserBloc>(context)
          .add(ProfileImageUpload(path: image.path));
    } else {
      print('No image selected.');
    }
  }

  void _saveChanges() {
    if (_key.currentState.validate()) {
      User _updatedUser = User(
        userId: _user.userId,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        phoneNumber: _phoneController.text,
        verified: _user.verified,
        postCode: _zipController.text,
        city: _cityController.text,
        street: _streetController.text,
        houseNumber: _numberController.text,
        lesseeRating: _user.lesseeRating,
        numberOfLesseeRatings: _user.numberOfLesseeRatings,
        lessorRating: _user.lessorRating,
        numberOfLessorRatings: _user.numberOfLessorRatings,
        dateOfBirth: _user.dateOfBirth,
      );
      BlocProvider.of<UserBloc>(context).add(UserUpdate(user: _updatedUser));
    } else {
      print('falsch');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserSuccess) {
          showFlushbar(context: context, message: 'Änderungen übernommen');
        } else if (state is UserFailure) {
          showFlushbar(context: context, message: state.error);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(
          children: [
            // Profile image
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
              decoration: new BoxDecoration(
                color: Color(0xFF202020),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => _selectImageSource(parentContext: context),
                    child: Container(
                      width: 0.3 * MediaQuery.of(context).size.width,
                      height: 0.3 * MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: _user.profilePicture != ''
                                ? CachedNetworkImage(
                                    imageUrl: _user.profilePicture,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Image(
                                      image:
                                          AssetImage('assets/images/jett.jpg'),
                                    ),
                                    errorWidget: (context, url, error) => Image(
                                      image:
                                          AssetImage('assets/images/jett.jpg'),
                                    ),
                                  )
                                : Image(
                                    image: AssetImage('assets/images/jett.jpg'),
                                  ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  width: 50.0,
                                  height: 50.0,
                                  color: Colors.black54,
                                  child: Icon(
                                    Feather.camera,
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Mieterbewertung',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              Text(
                                '${_user.lessorRating} ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              Icon(
                                Feather.star,
                                color: Colors.purple,
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                '(${_user.numberOfLesseeRatings})',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            'Vermieterbewertung',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              Text(
                                '${_user.lessorRating} ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              Icon(
                                Feather.star,
                                color: Colors.purple,
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                '(${_user.numberOfLessorRatings})',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
              decoration: new BoxDecoration(
                color: Color(0xFF202020),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Form(
                key: _key,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
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
                      height: 10.0,
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
                        SizedBox(
                          width: 10.0,
                        ),
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
                        SizedBox(
                          width: 10.0,
                        ),
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
                      height: 10.0,
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
                      height: 10.0,
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
                      height: 30.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0)),
                        child: Text('Speichern'),
                        onPressed: () => _saveChanges(),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        color: Colors.black,
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                            side:
                                BorderSide(color: Colors.purple, width: 1.75)),
                        child: Text('Passwort ändern'),
                        onPressed: () => pushNewScreen(
                          context,
                          screen: UpdatePasswordScreen(),
                        ),
                        // _updatePassword(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 75.0,
            ),
          ],
        ),
      ),
    );
  }
}
