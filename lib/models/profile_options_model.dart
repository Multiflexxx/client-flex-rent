import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ProfileOption {
  IconData icon;
  String name;
  String optionId;

  ProfileOption(String optionId, String name, IconData icon) {
    this.icon = icon;
    this.name = name;
    this.optionId = optionId;
  }
}

List<ProfileOption> profileOptions = [
  ProfileOption(
      'personalInfo', 'Meine Informationen', MaterialIcons.perm_identity),
  ProfileOption('myitems', 'Meine Mietgegenstände', MaterialIcons.drafts),
  ProfileOption(
      'paymentinfo', 'Zahlungsinformationen', MaterialIcons.credit_card),
  ProfileOption('karmainfos', 'Mein Karma-Score', MaterialIcons.stars),
  ProfileOption('settings', 'Einstellungen', MaterialIcons.settings),
  ProfileOption('logout', 'Abmelden', MaterialIcons.exit_to_app),
];
