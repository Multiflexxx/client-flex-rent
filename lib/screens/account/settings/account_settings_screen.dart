import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/logic/blocs/authentication/authentication.dart';
import 'package:rent/models/profile_options_model.dart';
import 'package:rent/screens/404.dart';
import 'package:rent/screens/account/settings/personal_info_screen.dart';
import 'package:rent/screens/account/settings/settings_screen.dart';
import 'package:rent/widgets/layout/standard_sliver_appbar_list.dart';

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
          color: Color(0xFF202020),
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
                    color: Colors.purple,
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                  Text(
                    profileOption.name,
                    style: TextStyle(
                      color: Colors.white,
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
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
