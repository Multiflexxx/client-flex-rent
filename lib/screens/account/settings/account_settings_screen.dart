import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flexrent/logic/blocs/authentication/authentication.dart';
import 'package:flexrent/screens/404.dart';
import 'package:flexrent/screens/account/settings/personal_info_screen.dart';
import 'package:flexrent/screens/account/settings/settings_screen.dart';
import 'package:flexrent/widgets/layout/standard_sliver_appbar_list.dart';

class ProfileOption {
  String optionId;
  String name;
  IconData icon;

  ProfileOption(String optionId, String name, IconData icon) {
    this.optionId = optionId;
    this.name = name;
    this.icon = icon;
  }
}

List<ProfileOption> profileOptions = [
  ProfileOption('personalInfo', 'Meine Informationen', Feather.user),
  ProfileOption('paymentinfo', 'Zahlungsinformationen', Feather.credit_card),
  ProfileOption('settings', 'Einstellungen', Feather.settings),
  ProfileOption('logout', 'Abmelden', Feather.log_out),
];

class AccountSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StandardSliverAppBarList(
      title: 'Einstellungen',
      bodyWidget: _AccountSettingsBody(),
    );
  }
}

class _AccountSettingsBody extends StatelessWidget {
  final routes = {
    'personalInfo': PersonalInfoScreen(),
    'paymentInfo': PageNotFound(),
    'settings': AppSettingsScreen(),
    'logout': PageNotFound(),
  };

  List<Widget> _getWidgetList({BuildContext context}) {
    List<Widget> _optionList = List<Widget>();

    for (ProfileOption profileOption in profileOptions) {
      _optionList.add(
        _listUi(context: context, profileOption: profileOption),
      );
    }
    return _optionList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _getWidgetList(context: context),
    );
  }

  Widget _listUi({BuildContext context, ProfileOption profileOption}) {
    return GestureDetector(
      onTap: () {
        if (profileOption.optionId != 'logout') {
          pushNewScreenWithRouteSettings(
            context,
            settings: RouteSettings(name: profileOption.optionId),
            screen: routes[profileOption.optionId] ?? PageNotFound(),
          );
        } else {
          BlocProvider.of<AuthenticationBloc>(context).add(UserLoggedOut());
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
