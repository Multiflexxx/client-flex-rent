import 'dart:io';
import 'package:filesize/filesize.dart';
import 'package:flexrent/logic/blocs/authentication/authentication.dart';
import 'package:flexrent/screens/authentication/no_access_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HelperService {
  static Future<File> compressFile(File file) async {
    final String filePath = file.absolute.path;

    print(filePath);

    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: 25,
    );

    print(filesize(file.lengthSync()));
    print(filesize(result.lengthSync()));

    return result;
  }

  static bool _isLoggedIn({BuildContext context}) {
    final state = BlocProvider.of<AuthenticationBloc>(context).state;
    if (state.user != null) {
      return true;
    }
    return false;
  }

  static pushToProtectedScreen(
      {BuildContext context, Widget screen, String popRouteName, bool navbar}) {
    if (_isLoggedIn(context: context)) {
      pushNewScreen(
        context,
        withNavBar: navbar,
        screen: screen,
      );
    } else {
      pushNewScreenWithRouteSettings(
        context,
        settings: RouteSettings(name: NoAccessScreen.routeName),
        screen: NoAccessScreen(
          popRouteName: popRouteName,
        ),
      );
    }
  }
}
