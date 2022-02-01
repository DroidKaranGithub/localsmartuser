import 'dart:async';
import 'package:client_ajay_user_panel/Constants/Constant.dart';
import 'package:flutter/material.dart';
import 'Auth/Login/Login.dart';
import 'DashboardScreens/Ask/Ask.dart';

class SplashScreen extends StatefulWidget {
  static String id = "SpalasScreen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(context, MaterialPageRoute(builder: (context) {
              return login == true ? Ask() : Login();
            })));
  }

  bool? login = Shared.pref.getBool("Login");
  @override
  Widget build(BuildContext context) {
    var height = AppBar().preferredSize.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        child: Stack(
          //mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: height + 140,
                  ),
                  Container(
                    height: 230,
                    color: Colors.white,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.asset(
                            "assets/images/logo.png",
                            //  height: 250,
                            scale: 2.5,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            //SizedBox(height: 80,),
            Align(
                alignment: Alignment.bottomRight,
                child: Image.asset('assets/images/background1.png')),
            Align(
                alignment: Alignment.bottomRight,
                child: Image.asset('assets/images/background.png'))
          ],
        ),
      ),
    );
  }
}
