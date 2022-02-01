import 'dart:convert';
import 'dart:developer';

import 'package:client_ajay_user_panel/ApiRepository/ApiRepository.dart';
import 'package:client_ajay_user_panel/ConstantDrawer.dart';
import 'package:client_ajay_user_panel/Constants/Constant.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Responses/ResponsesModalClass.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Shop/Shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class Responses extends StatefulWidget {
  int? QueryId;
  Responses({this.QueryId});
  static String id = "Responses";
  @override
  _ResponsesState createState() => _ResponsesState();
}

class _ResponsesState extends State<Responses> {
  int? UserId = Shared.pref.getInt("userPerticulaId");
  List Rate = [];
  List Response = [];
  List MobileNumber = [];
  List Title = [];
  List Address = [];
  List Shop = [];
  List Id = [];
  List Images = [];
  bool? Status;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  Future _makingPhoneCall(String mobile) async {
    String url = "tel:" + mobile;
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getData(int queryid) {
    int? userId = int.parse(Shared.pref.getInt("userParticulaId").toString());
    print(
        "qid $queryid and user id ${Shared.pref.getInt("userParticulaId").toString()}");
    ApiRepository().GetResponse(userId, queryid).then((value) {
      //log(value.body);

      //print(jsonDecode(value.body));
      var body = ResponseModalClass.fromJson(jsonDecode(value.body));
      Status = body.status;

      print(Status);
      setState(() {});
      if (body.status.toString() == "true") {
        var body1 = ResponseModalClass.fromJson(jsonDecode(value.body)).data;
        print(body1);

        if (body1!.isEmpty) {
          Fluttertoast.showToast(msg: "Data is not available");
        } else {
          body1.forEach((element) {
            Shared.pref.setInt("responseId", int.parse(element.id.toString()));
            print(body1.length);
            print(element.shop!.shopName);

            Title.add(element.title);
            MobileNumber.add(element.shop?.contactNumber);
            Rate.add(element.price);

            //   Images.add(element.productImage);
            Id.add(element.shop?.id);
            Shop.add(element.shop!.shopName);
            Address.add(element.shop!.address);
          });
        }
      }

      print("titles $Title");
      print("mobiles $MobileNumber");
      print("rates $Rate");
      print("images $Images");
      print("id is ${Id}");
      print("shops $Shop");
      print("address $Address");
    });
  }

  void initState() {
    super.initState();
    getData(
      widget.QueryId!,
    );
    //print("_____________________");
    //print();
  }

  Widget UpperBody(BuildContext context) {
    var height = AppBar().preferredSize.height;
    return Column(
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
              'Responses',
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
                  '',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget LowerBody(BuildContext context) {
    TextStyle style = Theme.of(context)
        .textTheme
        .headline1!
        .copyWith(color: orange, fontWeight: FontWeight.bold, fontSize: 20);
    var height = AppBar().preferredSize.height;
    return Expanded(
      child: ListView.builder(
        itemCount: Id.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Shared.pref.setString("price", Rate[index].toString());

              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ShopName();
              }));
            },
            child: Card(
              color: Color(0xFFF8F5F5),
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                // color: Colors.green,
                                //    height: 100,
                                child: Column(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 0),
                                      child: Image.asset(
                                        "assets/images/tag.png",
                                        scale: 1.4,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 0),
                                      child: Image.asset(
                                        "assets/images/rupee.png",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 0),
                                      child: Image.asset(
                                          "assets/images/store.png"),
                                    ),
                                    // SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                          "assets/images/location.png"),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  //color: Colors.red,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, top: 6),
                                        child: Text(
                                            Shared.pref
                                                .getString("title")
                                                .toString(),
                                            style: style),
                                      ),
                                      // SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, top: 4),
                                        child: Text(Rate[index].toString(),
                                            style: style),
                                      ),
                                      // SizedBox(height: 30),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, top: 4),
                                        child: Text(
                                          Shop[index],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1!
                                              .copyWith(
                                                  color: Blue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                        ),
                                      ),
                                      // SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, top: 7),
                                        child: Text(
                                          Address[index],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            color: Colors.white,
                            width: 120,
                            child: Image(
                                image: AssetImage("assets/images/sofa.png")))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: MobileNumber[index] == null
                          ? () {
                              Fluttertoast.showToast(
                                  msg: "Mobile number is not available");
                            }
                          : () {
                              _makingPhoneCall(MobileNumber[index]);
                            },
                      child: Card(
                        elevation: 10,
                        child: Container(
                          // height: 20,
                          width: 130,
                          decoration: BoxDecoration(
                              color: orange,
                              borderRadius: BorderRadius.circular(5)),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Call Now",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = AppBar().preferredSize.height;
    return Scaffold(
      key: _key,
      drawerEnableOpenDragGesture: false,
      drawer: drawer(),
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Status == true
              ? Column(
                  children: [UpperBody(context), LowerBody(context)],
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
