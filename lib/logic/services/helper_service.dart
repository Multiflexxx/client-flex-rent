import 'dart:io';
import 'package:flexrent/logic/blocs/authentication/authentication.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/screens/authentication/no_access_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HelperService {
  static const _storage = FlutterSecureStorage();

  static Future<Session> getSession() async {
    final String sessionId = await _storage.read(key: 'sessionId');
    final String userId = await _storage.read(key: 'userId');

    Session session = Session(sessionId: sessionId, userId: userId);
    return session;
  }

  static Future<File> compressFile(File file) async {
    final String filePath = file.absolute.path;

    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: 25,
    );

    return result;
  }

  static bool isLoggedIn({BuildContext context}) {
    final state = BlocProvider.of<AuthenticationBloc>(context).state;
    if (state.user != null) {
      return true;
    }
    return false;
  }

  static User getUser({BuildContext context}) {
    final state = BlocProvider.of<AuthenticationBloc>(context).state;
    return state.user;
  }

  static pushToProtectedScreen({
    BuildContext context,
    Widget targetScreen,
    String popRouteName,
    bool hideNavBar,
    VoidCallback hideNavBarFunction,
  }) {
    if (isLoggedIn(context: context)) {
      if (hideNavBar) {
        hideNavBarFunction();
      }
      pushNewScreen(
        context,
        screen: targetScreen,
      );
    } else {
      hideNavBarFunction();
      pushNewScreenWithRouteSettings(
        context,
        settings: RouteSettings(name: NoAccessScreen.routeName),
        screen: NoAccessScreen(
          popRouteName: popRouteName,
          targetScreen: targetScreen,
          hideNavBarFunction: hideNavBarFunction,
          realScreenName: 'reservationScreen',
        ),
        pageTransitionAnimation: PageTransitionAnimation.scale,
      );
    }
  }
}
