import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexrent/logic/blocs/offer/offer.dart';
import 'package:flexrent/logic/exceptions/exceptions.dart';
import 'package:flexrent/logic/services/services.dart';
import 'package:flexrent/widgets/styles/buttons_styles/button_purple_styled.dart';
import 'package:flexrent/widgets/styles/buttons_styles/button_transparent_styled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flexrent/logic/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:flexrent/logic/blocs/user/bloc/user_bloc.dart';
import 'package:flexrent/logic/models/user/user.dart';
import 'package:flexrent/screens/account/settings/update_password_screen.dart';
import 'package:flexrent/widgets/camera/image_source.dart';
import 'package:flexrent/widgets/styles/flushbar_styled.dart';
import 'package:flexrent/widgets/styles/formfield_styled.dart';
import 'package:flexrent/widgets/layout/standard_sliver_appbar_list.dart';

class PersonalInfoScreen extends StatelessWidget {
  final VoidCallback hideNavBarFunction;

  const PersonalInfoScreen({Key key, this.hideNavBarFunction})
      : super(key: key);

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
    setState(() {
      _user = HelperService.getUser(context: context);
    });
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
      final _image = await HelperService.compressFile(File(image.path));

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

  void _deleteUser() async {
    try {
      await ApiUserService().deleteUser(user: _user);
      BlocProvider.of<OfferBloc>(context).add(OfferTickerStopped());
      BlocProvider.of<AuthenticationBloc>(context).add(UserSignOut());
      Navigator.of(context).pop();
    } on UserException catch (e) {
      showFlushbar(context: context, message: e.message);
    } catch (e) {
      print('Ok');
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
                color: Theme.of(context).cardColor,
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
                                    color: Theme.of(context).primaryColor,
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
                              color: Theme.of(context).primaryColor,
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
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              Icon(
                                Feather.star,
                                color: Theme.of(context).accentColor,
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                '(${_user.numberOfLesseeRatings})',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
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
                              color: Theme.of(context).primaryColor,
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
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              Icon(
                                Feather.star,
                                color: Theme.of(context).accentColor,
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                '(${_user.numberOfLessorRatings})',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
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
                color: Theme.of(context).cardColor,
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
                              color: Theme.of(context).primaryColor,
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
                              color: Theme.of(context).primaryColor,
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
                              color: Theme.of(context).primaryColor,
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
                        color: Theme.of(context).primaryColor,
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
                        color: Theme.of(context).primaryColor,
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
                    PurpleButton(
                      text: Text('Speichern'),
                      onPressed: () => _saveChanges(),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TransparentButton(
                      text: Text('Passwort ändern'),
                      onPressed: () => pushNewScreen(
                        context,
                        screen: UpdatePasswordScreen(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _deleteUser(),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
                decoration: new BoxDecoration(
                  // color: Theme.of(context).cardColor,
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Feather.trash,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Account löschen',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18.0,
                                    height: 1.35,
                                  ),
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Ionicons.ios_arrow_forward,
                        size: 30.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
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
