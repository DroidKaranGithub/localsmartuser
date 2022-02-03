import 'package:flutter/material.dart';

import 'Auth/Login/Login.dart';
import 'Constants/Constant.dart';
import 'DashboardScreens/Ask/Ask.dart';
import 'DashboardScreens/Ask/Coupons.dart';
import 'DashboardScreens/Inquries/Inquries.dart';
import 'DashboardScreens/Profile/Profile.dart';
import 'DashboardScreens/Responses/Responses.dart';
import 'DashboardScreens/Shop/Shop.dart';

class drawer extends StatefulWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  _drawerState createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
        child: Drawer(
          child: Container(
            decoration: BoxDecoration(
                color: orange.withOpacity(0.12),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                            color: orange,
                            borderRadius: BorderRadius.circular(40)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Shared.pref
                                    .getString("PROFILE_IMAGE")
                                    .toString()
                                    .isEmpty
                                ? Icon(
                                    Icons.person,
                                    size: 30,
                                    color: Colors.white,
                                  )
                                : Image.network(
                                    // "https://th.bing.com/th/id/OIP.kcaJsnMsMsFRdU6d1m2v6AHaHa?pid=ImgDet&rs=1"
                                    Shared.pref
                                        .getString("PROFILE_IMAGE")
                                        .toString(),
                                    fit: BoxFit.cover,
                                  )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //  Shared.pref.setString("UserName", body1.name.toString());
//          Shared.pref.setString("mobileNumber", body1.phone.toString());
                      Text(
                        Shared.pref.getString("NAME") == null
                            ? ""
                            : Shared.pref.getString("NAME") == "null"
                                ? ""
                                : Shared.pref.getString("NAME")!,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 23),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // Text(
                      //   Shared.pref.getString("EMAIL").toString().isNotEmpty
                      //       ? Shared.pref.getString("EMAIL").toString()
                      //       : "",
                      //   style: TextStyle(color: orange),
                      // ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      Text(
                        Shared.pref.getString("mobileNumber").toString(),
                        style: TextStyle(color: orange),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Ask();
                              }));
                            },
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.home,
                                  color: Colors.black,
                                  size: 25,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Home',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: DarkBlue,
                                            fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Profile();
                              }));
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.black,
                                  size: 25,
                                ),
                                //  SizedBox(width: 20,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Profile',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: DarkBlue,
                                            fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Inquries();
                              }));
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.image_search_rounded,
                                  color: Colors.black,
                                  size: 25,
                                ),
                                //SizedBox(width: 20,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Inquiries',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: DarkBlue,
                                            fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // GestureDetector(
                          //   onTap: (){
                          //     Navigator.push(context, MaterialPageRoute(builder: (context){
                          //       return ShopName();
                          //     }));
                          //   },
                          //   child: Row(
                          //     children: [
                          //       Image.asset("assets/images/bid.png"),
                          //       // SizedBox(width: 20,),
                          //       Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: Text('Bid & Buy',style: Theme.of(context).textTheme.headline1!.copyWith(
                          //             fontWeight: FontWeight.bold,color: DarkBlue,fontSize: 20
                          //         ),),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(height: 10,),
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Coupons();
                              }));
                            },
                            child: Row(
                              children: [
                                Image.asset("assets/images/discount.png"),
                                // SizedBox(width: 20,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Coupons',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: DarkBlue,
                                            fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ),
                          // SizedBox(height: 10,),
                          //
                          // Row(
                          //   children: [
                          //     Image.asset("assets/images/help.png"),
                          //     //SizedBox(width: 20,),
                          //     Padding(
                          //       padding: const EdgeInsets.all(8.0),
                          //       child: Text('Help & Support',style: Theme.of(context).textTheme.headline1!.copyWith(
                          //           fontWeight: FontWeight.bold,color: DarkBlue,fontSize: 20
                          //       ),),
                          //     )
                          //
                          //   ],
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Shared.pref.clear();
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (cnt) {
                                return Login();
                              }));
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.exit_to_app,
                                  color: Colors.black,
                                  size: 25,
                                ),
                                // SizedBox(width: 20,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Sign Out',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: orange,
                                            fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
