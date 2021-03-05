import 'package:flexrent/logic/blocs/authentication/authentication.dart';
import 'package:flexrent/screens/authentication/no_access_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_overview_screen.dart';

class ChatOverviewRootScreen extends StatelessWidget {
  static String routeName = 'rootTabScreen';

  final VoidCallback hideNavBarFunction;

  const ChatOverviewRootScreen({Key key, this.hideNavBarFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          return ChatOverviewScreen();
        }
        return NoAccessScreen(
          popRouteName: ChatOverviewRootScreen.routeName,
          targetScreen: ChatOverviewRootScreen(
            hideNavBarFunction: hideNavBarFunction,
          ),
          hideNavBarFunction: hideNavBarFunction,
          realScreenName: 'chatOverviewScreen',
        );
      },
    );
  }
}
