import 'dart:convert';

import 'package:client_ajay_user_panel/ApiRepository/ApiRepository.dart';
import 'package:client_ajay_user_panel/Auth/Register/RegisterUserModalClass.dart';
import 'package:client_ajay_user_panel/Constants/ColorButton.dart';
import 'package:client_ajay_user_panel/Constants/Constant.dart';
import 'package:client_ajay_user_panel/Constants/InputField.dart';
import 'package:client_ajay_user_panel/Constants/LoaderClass.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Ask/Ask.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Profile/EditProfile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_autofill/otp_autofill.dart';

class Profile extends StatefulWidget {
  static String id = "Profile";
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  OverlayEntry? loader;

  @override
  Widget build(BuildContext context) {
    loader = Loader.overlayLoader(context);
    var height = AppBar().preferredSize.height;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: height,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              'assets/images/otparrow.png',
                              scale: 1.2,
                            )),
                        Column(
                          children: [
                            Container(
                              width: 75,
                              height: 75,
                              decoration: BoxDecoration(
                                  color: orange,
                                  borderRadius: BorderRadius.circular(40)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Shared.pref.getString("PROFILE_IMAGE") ==
                                        null
                                    ? Icon(
                                        Icons.person,
                                        size: 30,
                                        color: Colors.white,
                                      )
                                    : Image.network(
                                        Shared.pref.getString("PROFILE_IMAGE")!,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              Shared.pref.getString("NAME") == null
                                  ? ""
                                  : Shared.pref.getString("NAME") == "null"
                                      ? ""
                                      : Shared.pref.getString("NAME")!,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: orange),
                            )
                          ],
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return EditProfile();
                              })).then((value) {
                                setState(() {});
                              });
                            },
                            child: Icon(
                              Icons.edit,
                              color: orange,
                              size: 30,
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                  color: OtpColor,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(70))),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Email',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: orange,
                                    fontSize: 20),
                          ),
                          // SizedBox(width: 20,),
                          Container(
                            decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(20)),
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                Shared.pref.getString("EMAIL") == null
                                    ? ""
                                    : Shared.pref.getString("EMAIL") == "null"
                                        ? ""
                                        : Shared.pref.getString("EMAIL")!,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: orange,
                                        fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Contact",
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: orange,
                                    fontSize: 20),
                          ),
                          // SizedBox(width: 20,),
                          Container(
                            decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(20)),
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                Shared.pref.getString("PHONE") == null
                                    ? ""
                                    : Shared.pref.getString("PHONE") == "null"
                                        ? ""
                                        : Shared.pref.getString("PHONE")!,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: orange,
                                        fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'City',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: orange,
                                    fontSize: 20),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(20)),
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                "Udaipur",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: orange,
                                        fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      InkWell(
                        onTap: () {},
                        child: ColorButton(
                          RoundCorner: true,
                          width: 200,
                          // color: color,
                          title: 'Update',
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
