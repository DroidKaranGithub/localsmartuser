import 'dart:io';

import 'package:client_ajay_user_panel/ConstantDrawer.dart';
import 'package:client_ajay_user_panel/Constants/Constant.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Ask/AskForm/AskForm.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Ask/Coupons.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Ask/Recording/Recording.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Inquries/Inquries.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Responses/Responses.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Shop/Shop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Ask extends StatefulWidget {
  static String id = "Ask";
  @override
  _AskState createState() => _AskState();
}

class _AskState extends State<Ask> {
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "press back twice to exit");
      return Future.value(false);
    }
    return exit(0);
  }

  DateTime? currentBackPressTime;
  var height;
  final GlobalKey<ScaffoldState> _key1 = GlobalKey();
  @override
  Widget build(BuildContext context) {
    height = AppBar().preferredSize.height;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: _key1,
        backgroundColor: white,
        drawerEnableOpenDragGesture: false,
        drawer: drawer(),
        body: Container(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: height,
                ),
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          _key1.currentState!.openDrawer();
                        },
                        child: Icon(
                          Icons.menu_rounded,
                          color: orange,
                        )),
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Recording.id);
                        },
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: orange,
                          child: Text(
                            'ASK',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Image.asset('assets/images/Ask1.png'),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
