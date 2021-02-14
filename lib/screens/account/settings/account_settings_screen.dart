import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/helper_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flexrent/logic/blocs/authentication/authentication.dart';
import 'package:flexrent/screens/404.dart';
import 'package:flexrent/screens/account/settings/personal_info_screen.dart';
import 'package:flexrent/screens/account/settings/app_settings_screen.dart';
import 'package:flexrent/widgets/layout/standard_sliver_appbar_list.dart';

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
          setState(() {});
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
      ProfileOption(
        optionId: 'logout',
        name: 'Abmelden',
        icon: Feather.log_out,
      ),
    ];

    List<Widget> _optionList = List<Widget>();

    for (ProfileOption profileOption in profileOptions) {
      if (profileOption.optionId == 'logout' &&
          !HelperService.isLoggedIn(context: context)) {
        break;
      }

      _optionList.add(
        _listUi(context: context, profileOption: profileOption),
      );
    }
    return _optionList;
  }

  Widget _listUi({BuildContext context, ProfileOption profileOption}) {
    return GestureDetector(
      onTap: () {
        if (profileOption.optionId != 'logout') {
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
        } else {
          BlocProvider.of<AuthenticationBloc>(context).add(UserSignOut());
          print(ModalRoute.of(context).settings.name);
          // Navigator.pop(context);
        }
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
