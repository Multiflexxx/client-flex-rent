import 'package:flexrent/logic/blocs/offer/bloc/offer_bloc.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/helper_service.dart';
import 'package:flexrent/screens/account/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flexrent/logic/blocs/authentication/authentication.dart';
import 'package:flexrent/screens/404.dart';
import 'package:flexrent/screens/account/settings/personal_info_screen.dart';
import 'package:flexrent/screens/account/settings/app_settings_screen.dart';
import 'package:flexrent/widgets/layout/standard_sliver_appbar_list.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AccountSettingsScreen extends StatefulWidget {
  static String routeName = 'accountSettingScreen';

  final VoidCallback hideNavBarFunction;

  const AccountSettingsScreen({Key key, this.hideNavBarFunction})
      : super(key: key);

  @override
  _AccountSettingsScreenState createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationAuthenticated) {
          setState(() {});
        }
        if (state is AuthenticationNotAuthenticated) {
          // setState(() {});
          Navigator.of(context).popUntil(
            ModalRoute.withName(AccountScreen.routeName),
          );
        }
      },
      child: StandardSliverAppBarList(
        title: 'Einstellungen',
        bodyWidget: _AccountSettingsBody(
          hideNavBarFunction: widget.hideNavBarFunction,
        ),
      ),
    );
  }
}

class _AccountSettingsBody extends StatelessWidget {
  final VoidCallback hideNavBarFunction;

  _AccountSettingsBody({Key key, this.hideNavBarFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _getWidgetList(context: context),
    );
  }

  List<Widget> _getWidgetList({BuildContext context}) {
    List<ProfileOption> profileOptions = [
      ProfileOption(
        optionId: 'personalInfo',
        name: 'Meine Informationen',
        icon: Feather.user,
        targetScreen: PersonalInfoScreen(
          hideNavBarFunction: hideNavBarFunction,
        ),
      ),
      ProfileOption(
        optionId: 'paymentinfo',
        name: 'Zahlungsinformationen',
        icon: Feather.credit_card,
        targetScreen: PageNotFound(
          hideNavBarFunction: hideNavBarFunction,
        ),
      ),
      ProfileOption(
        optionId: 'settings',
        name: 'Einstellungen',
        icon: Feather.settings,
        targetScreen: AppSettingsScreen(
          hideNavBarFunction: hideNavBarFunction,
        ),
      ),
    ];

    List<Widget> _optionList = List<Widget>();

    for (ProfileOption profileOption in profileOptions) {
      _optionList.add(
        _listUi(context: context, profileOption: profileOption),
      );
    }

    if (HelperService.isLoggedIn(context: context)) {
      _optionList.add(_getLogOutButton(context: context));
    }

    return _optionList;
  }

  Widget _getLogOutButton({BuildContext context}) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<OfferBloc>(context).add(OfferTickerStopped());
        BlocProvider.of<AuthenticationBloc>(context).add(UserSignOut());
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
        padding: EdgeInsets.symmetric(vertical: 8.0),
        decoration: new BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Feather.log_out,
                    size: 25.0,
                    color: Theme.of(context).accentColor,
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      if (state is AuthenticationStartLogOut) {
                        return Row(
                          children: [
                            Text(
                              'Sicher abmelden',
                              style: TextStyle(
                                fontSize: 21.0,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 1.2,
                              ),
                            ),
                            SizedBox(
                              width: 25.0,
                            ),
                            SpinKitWave(
                              duration: Duration(seconds: 1),
                              color: Theme.of(context).primaryColor,
                              type: SpinKitWaveType.start,
                              size: 25,
                            ),
                          ],
                        );
                      }
                      return Text(
                        'Abmelden',
                        style: TextStyle(
                          fontSize: 21.0,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1.2,
                        ),
                      );
                    },
                  ),
                ],
              ),
              Icon(
                Ionicons.ios_arrow_forward,
                size: 25.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listUi({BuildContext context, ProfileOption profileOption}) {
    return GestureDetector(
      onTap: () {
        HelperService.pushToProtectedScreen(
          context: context,
          hideNavBar: false,
          targetScreen: profileOption.targetScreen ??
              PageNotFound(
                hideNavBarFunction: hideNavBarFunction,
              ),
          popRouteName: AccountSettingsScreen.routeName,
          hideNavBarFunction: hideNavBarFunction,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
        padding: EdgeInsets.symmetric(vertical: 8.0),
        decoration: new BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    profileOption.icon,
                    size: 25.0,
                    color: Theme.of(context).accentColor,
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                  Text(
                    profileOption.name,
                    style: TextStyle(
                      fontSize: 21.0,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              Icon(
                Ionicons.ios_arrow_forward,
                size: 25.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
