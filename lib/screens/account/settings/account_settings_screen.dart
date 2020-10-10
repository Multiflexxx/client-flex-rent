import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/logic/blocs/authentication/authentication.dart';
import 'package:rent/models/profile_options_model.dart';
import 'package:rent/screens/404.dart';
import 'package:rent/screens/account/settings/personal_info.dart';
import 'package:rent/screens/account/settings/settings.dart';

class AccountSettingsScreen extends StatelessWidget {
  final routes = {
    'personalInfo': PersonalInfo(),
    'paymentInfo': PageNotFound(),
    'karmaInfo': PageNotFound(),
    'settings': AppSettings(),
    'logout': PageNotFound(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView.builder(
        itemCount: profileOptions.length,
        itemBuilder: (context, index) {
          ProfileOption option = profileOptions[index];
          return ListTile(
              onTap: () {
                if (index < profileOptions.length - 1) {
                  print(option.optionId);
                  pushNewScreenWithRouteSettings(
                    context,
                    settings: RouteSettings(name: option.optionId),
                    screen: routes[option.optionId] ?? PageNotFound(),
                    withNavBar: true,
                  );
                } else {
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(UserLoggedOut());
                }
              },
              leading: Icon(
                option.icon,
                color: Colors.white,
              ),
              title: Text(
                option.name,
                style: TextStyle(color: Colors.white),
              ));
        },
      ),
    ));
  }
}
