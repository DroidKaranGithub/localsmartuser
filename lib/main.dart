import 'package:client_ajay_user_panel/Auth/Login/Login.dart';
import 'package:client_ajay_user_panel/Auth/OTP.dart';
import 'package:client_ajay_user_panel/Auth/Register/Register.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Ask/Ask.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Ask/Recording/Recording.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Profile/Profile.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Responses/Responses.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Shop/Shop.dart';
import 'package:client_ajay_user_panel/SplashScreen.dart';

import 'package:flutter/material.dart';
import 'Constants/Constant.dart';
import 'DashboardScreens/Ask/AskForm/AskForm.dart';
import 'DashboardScreens/Ask/Coupons.dart';
import 'DashboardScreens/Inquries/Inquries.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DashboardScreens/Profile/EditProfile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Shared.pref = await SharedPreferences.getInstance();
  runApp(Material());
}

class Material extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LocalsMart User',
      theme: ThemeData(
        textTheme: TextTheme(
          headline1:
              TextStyle(color: Colors.orange, fontWeight: FontWeight.w100),
          headline2: TextStyle(
            color: Colors.orange,
            // fontWeight: FontWeight.w100
          ),
        ),
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        Profile.id: (context) => Profile(),
        EditProfile.id: (context) => EditProfile(),
        Ask.id: (context) => Ask(),
        AskForm.id: (context) => AskForm(),
        Recording.id: (context) => Recording(),
        SplashScreen.id: (context) => SplashScreen(),
        Login.id: (context) => Login(),
        Register.id: (context) => Register(),
        OTP.id: (context) => OTP(),
        Coupons.id: (context) => Coupons(),
        Inquries.id: (context) => Inquries(),
        Responses.id: (context) => Responses(),
        ShopName.id: (context) => ShopName(),
      },
    );
  }
}
