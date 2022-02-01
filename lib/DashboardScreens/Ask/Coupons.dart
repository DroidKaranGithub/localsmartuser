import 'package:client_ajay_user_panel/ConstantDrawer.dart';
import 'package:client_ajay_user_panel/Constants/constantDilog.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Ask/AskForm/AskForm.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:client_ajay_user_panel/Constants/ColorButton.dart';
import 'package:client_ajay_user_panel/Constants/Constant.dart';
import 'package:client_ajay_user_panel/Constants/InputField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';

class Coupons extends StatefulWidget {
  static String id = "Coupons";
  @override
  _CouponsState createState() => _CouponsState();
}

class _CouponsState extends State<Coupons> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  Widget Body(BuildContext context) {
    height = AppBar().preferredSize.height;
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      backgroundColor: white,
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          _key.currentState!.openDrawer();
                        },
                        child: Icon(
                          Icons.menu_rounded,
                          color: orange,
                        )),
                    Text(
                      'Coupons',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: orange,
                          ),
                    ),
                    Visibility(
                      visible: false,
                      child: CircleAvatar(
                        //radius: 50,
                        backgroundColor: orange,
                        child: Text(
                          'Ask',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  '14 Coupons',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: DarkBlue,
                      ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Your Rewards',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                ),
                Image.asset("assets/images/offer.png"),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(children: [
                      Image.asset(
                        'assets/images/rectangle1.png',
                        scale: 1.3,
                      ),
                      Positioned(
                          right: 0,
                          left: 0,
                          top: 20,
                          child: Image.asset(
                            'assets/images/star1.png',
                            scale: 1.5,
                          )),
                    ]),
                    Stack(
                      children: [
                        Image.asset(
                          'assets/images/rectangle2.png',
                          scale: 1.3,
                        ),
                        Positioned(
                            right: 0,
                            left: 0,
                            top: 20,
                            child: Image.asset(
                              'assets/images/star2.png',
                              scale: 1.5,
                            )),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: orange.withOpacity(0.2)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/images/money.png'),
                        Text(
                          'See Reward History',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: DarkBlue),
                        ),
                        Container(
                          height: 40,
                          width: 30,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // color: orange,
                              border: Border.all(color: orange)),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: orange,
                            size: 22,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  var height;
  @override
  Widget build(BuildContext context) {
    height = AppBar().preferredSize.height;
    return Scaffold(key: _key, drawer: drawer(), body: Body(context));
  }
}

class Level {}
