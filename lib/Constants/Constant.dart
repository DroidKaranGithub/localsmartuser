import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String BaseUrl = 'https://viragtea.com/localsmart/public/api/';

Color white = Colors.white;
Color orange = Color(0xFFF29538);
Color color = Color(0xFFF2EFEC);
Color Blue = Color(0xFF3C63AE);
Color DarkBlue = Color(0xFF040870);
Color OtpColor = Color(0xFFFFEFDE);

class Shared {
  static SharedPreferences pref =
      SharedPreferences.getInstance() as SharedPreferences;
}
