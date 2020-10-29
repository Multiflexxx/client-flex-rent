import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
