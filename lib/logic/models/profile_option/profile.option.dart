import 'package:flutter/material.dart';

class ProfileOption {
  String optionId;
  String name;
  IconData icon;
  Widget targetScreen;

  ProfileOption(
      {String optionId, String name, IconData icon, Widget targetScreen}) {
    this.optionId = optionId;
    this.name = name;
    this.icon = icon;
    this.targetScreen = targetScreen;
  }
}
