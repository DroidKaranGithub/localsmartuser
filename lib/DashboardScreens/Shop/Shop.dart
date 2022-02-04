import 'dart:convert';
import 'package:client_ajay_user_panel/ApiRepository/ApiRepository.dart';
import 'package:client_ajay_user_panel/ConstantDrawer.dart';
import 'package:client_ajay_user_panel/Constants/Constant.dart';
import 'package:client_ajay_user_panel/Constants/RoundedCard.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Shop/ShopDetailsResponse/shop_details_response.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Shop/ShopDetailsResponse/shop_image.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Shop/ShopModalClass.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopName extends StatefulWidget {
  // String? ShopId;
  // ShopName({this.ShopId});
  static String id = "ShopName";
  @override
  _ShopNameState createState() => _ShopNameState();
}

class _ShopNameState extends State<ShopName> {
  List<ShopImage> ImagesList = [];
  List Category = [];
  String? ShopName;
  bool? Status;
  String? OwnerName;
  String? categories = "";
  String contactNumber = "";
  String? Address;
  String? Url;
  String? Description;
  var bodyData;
  int? UserId = Shared.pref.getInt("userPerticularId");
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int Imageindex = 0;
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
            Expanded(
              child: Text(
                ShopName ?? "",
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: orange,
                    ),
                textAlign: TextAlign.center,
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

  Widget MiddleBody(BuildContext context) {
    var height = AppBar().preferredSize.height;
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: ImagesList.length > 0 ? ImagesList.length : 1,
          itemBuilder: (BuildContext context, int index, int realIdx) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 3,
              child: Container(
                // decoration:
                //     BoxDecoration(borderRadius: BorderRadius.circular(20)),
                width: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    ImagesList[index].image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
              height: 180,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              //enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              //  autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              // enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (val, page) {
                debugPrint("VAL-> $val");
                debugPrint("PAGE-> $page");
                Imageindex = val;
                setState(() {});
              }),
        ),
        // CarouselSlider(
        //   options: CarouselOptions(
        //       height: 180,
        //       aspectRatio: 16 / 9,
        //       viewportFraction: 1,
        //       initialPage: 0,
        //       //enableInfiniteScroll: true,
        //       reverse: false,
        //       autoPlay: true,
        //       //  autoPlayInterval: Duration(seconds: 3),
        //       autoPlayAnimationDuration: Duration(milliseconds: 800),
        //       autoPlayCurve: Curves.fastOutSlowIn,
        //       // enlargeCenterPage: true,
        //       scrollDirection: Axis.horizontal,
        //       onPageChanged: (val, page) {
        //         Imageindex = val;
        //         setState(() {});
        //       }),
        //   items: [
        //     ...ImagesList.map((e) {
        //       debugPrint("IMAGES_CARA-->${e} ");
        //       return Container(
        //         decoration:
        //             BoxDecoration(borderRadius: BorderRadius.circular(20)),
        //         width: 200,
        //         child: Card(
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(20)),
        //             elevation: 3,
        //             child: Padding(
        //               padding: const EdgeInsets.all(8.0),
        //               child: Image.network(
        //                 e['image'].toString(),
        //                 fit: BoxFit.cover,
        //               ),
        //             )),
        //       );
        //     }).toList(),
        //     // for (int i = 0; i < 2; i++)
        //     //   Container(
        //     //     decoration:
        //     //         BoxDecoration(borderRadius: BorderRadius.circular(20)),
        //     //     width: 200,
        //     //     child: Card(
        //     //         shape: RoundedRectangleBorder(
        //     //             borderRadius: BorderRadius.circular(20)),
        //     //         elevation: 3,
        //     //         child: Padding(
        //     //           padding: const EdgeInsets.all(8.0),
        //     //           child: Image.network(
        //     //             "https://thumbs.dreamstime.com/z/electronics-store-shelves-different-products-stand-row-photo-was-taken-one-supermarkets-toronto-57629991.jpg",
        //     //             fit: BoxFit.cover,
        //     //           ),
        //     //         )),
        //     //   )
        //   ],
        // ),
        new DotsIndicator(
            dotsCount: ImagesList.length > 0 ? ImagesList.length : 1,
            position: Imageindex.toDouble()),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/rupee.png",
            ),
            Text(
              '${Shared.pref.getString("price")}/-',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          Shared.pref.getString("title").toString(),
          style: Theme.of(context).textTheme.headline1!.copyWith(
              fontSize: 22, fontWeight: FontWeight.bold, color: orange),
        ),
        SizedBox(
          height: 10,
        ),
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Additional Details',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                CircleAvatar(
                    radius: 12,
                    backgroundColor: orange,
                    child: Image.asset(
                      "assets/images/shop.png",
                    )),
              ],
            ),
            children: [
              Container(
                //color: Colors.red,
                width: MediaQuery.of(context).size.width,
                child: Card(
                    elevation: 5,
                    color: Color(0xFFF8F5F5),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(Description.toString(),
                          textAlign: TextAlign.justify,
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: Colors.black, fontSize: 12)),
                    )),
              )
            ],
          ),
        ),
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'About the Seller',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Image.asset(
                  "assets/images/phone.png",
                ),
              ],
            ),
            children: [LowerBody(context)],
          ),
        )
      ],
    );
  }

  Widget LowerBody(BuildContext context) {
    TextStyle style = Theme.of(context)
        .textTheme
        .headline2!
        .copyWith(color: Colors.black, fontSize: 12);
    var height = AppBar().preferredSize.height;
    return Card(
      elevation: 5,
      color: Color(0xFFF8F5F5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Visibility(
              visible: ShopName != null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shop Name',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  RoundedCard(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(ShopName.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: style),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Owner Name',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                RoundedCard(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(OwnerName.toString(), style: style),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Category',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                RoundedCard(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(categories.toString(), style: style),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shop Address',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                RoundedCard(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(Address.toString(), style: style),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Website URL',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                RoundedCard(
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(Url.toString(), style: style)))
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  getData(int responseID) {
    print(responseID);
    ApiRepository().GetShopDetail(responseID).then((value) {
      var body = jsonDecode(value.body);
      //   print(body);
      Map<String, dynamic> jsonDetail = body;
      //log(body.toString());
      // print(jsonDetail);
      Status = body['status'];
      setState(() {});
      // var bodyDetails = ResponseDetails.fromJson(jsonDetail);
      ShopDetailsResponse shopDetailsResponse =
          ShopDetailsResponse.fromJson(value.body);
      //log(bodyData.toString());
      if (Status == true) {
        print("DESCRIPTION-->${shopDetailsResponse.response!.response}");
        // bodyData.forEach((element) {
        //   print(element);
        contactNumber = shopDetailsResponse.shop!.contactNumber!;
        ShopName = shopDetailsResponse.shop!.shopName;
        OwnerName = shopDetailsResponse.shop!.ownerName;
        Address = shopDetailsResponse.shop!.address;
        Url = shopDetailsResponse.shop!.websiteUrl;
        Description = shopDetailsResponse.response!.response;
        for (int i = 0; i < shopDetailsResponse.shop!.shopImages!.length; i++) {
          ImagesList.add(shopDetailsResponse.shop!.shopImages![i]);
        }
        for (int i = 0; i < shopDetailsResponse.shop!.categories!.length; i++) {
          Category.add(shopDetailsResponse.shop!.categories![i].name);
        }
        print("Category $Category");
        if (Category.isNotEmpty) {
          categories = Category.join(", ");
        }
        print("categories $categories");
        // for(int i=0; i<bodyDetails.sh)
        //   element.shopImages!
        //       .forEach((element) => ImagesList.add(element.image));
        // });
        print("shopname $ShopName");
        print("owner name $OwnerName");
        print("Address $Address");
        print("Url $Url");
        print("images $ImagesList");
      }
    });
  }

  void initState() {
    super.initState();
    int? responseID = Shared.pref.getInt("responseId");
    getData(responseID!);
  }

  @override
  Widget build(BuildContext context) {
    var height = AppBar().preferredSize.height;
    return Scaffold(
        key: _key,
        drawerEnableOpenDragGesture: false,
        drawer: drawer(),
        backgroundColor: Colors.white,
        body: (Status == true)
            ? Container(
                height: MediaQuery.of(context).size.height * 1,
                width: MediaQuery.of(context).size.width * 1,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        UpperBody(context),
                        SizedBox(
                          height: 30,
                        ),
                        MiddleBody(context),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            contactNumber.isEmpty
                                ? Fluttertoast.showToast(
                                    msg: "Contact number is not available")
                                : _makingPhoneCall(contactNumber);
                          },
                          child: Card(
                            elevation: 10,
                            child: Container(
                              // height: 20,
                              width: MediaQuery.of(context).size.width * 0.6,
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
              )
            : Container());
  }

  Future _makingPhoneCall(String mobile) async {
    String url = "tel:" + mobile;
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
