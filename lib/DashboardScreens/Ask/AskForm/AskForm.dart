import 'dart:convert';
import 'dart:io';

import 'package:client_ajay_user_panel/ApiRepository/ApiRepository.dart';
import 'package:client_ajay_user_panel/ConstantDrawer.dart';
import 'package:client_ajay_user_panel/Constants/ColorButton.dart';
import 'package:client_ajay_user_panel/Constants/Constant.dart';
import 'package:client_ajay_user_panel/Constants/InputField.dart';
import 'package:client_ajay_user_panel/Constants/LoaderClass.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Ask/AskForm/AskFormModaClass.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Inquries/Inquries.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as http_parser;

class AskForm extends StatefulWidget {
  static String id = "AskForm";
  @override
  _AskFormState createState() => _AskFormState();
}

class _AskFormState extends State<AskForm> {
  bool isUrlError = false;
  String validationMessage = "";
  String? UserId = Shared.pref.getString("UserID");
  OverlayEntry? loader;
  Dio dio = new Dio();
  FormData formdata = new FormData();
  int update = 1;
  final picker = ImagePicker();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String? Description = "";
  String Url = "";
  FormData formData = FormData();
  File? pickedFile;
  String? ImageUrl;
  File? imagePath;
  bool? IsImage = false;
  var height;
  @override
  void initState() {
    super.initState();
    // Loader.hideLoader(loader!);
  }

  @override
  void dispose() {
    super.dispose();
    Loader.removeLoader(loader!);
  }

  // senData(String imageUrl, String url, String desc) {
  //   ApiRepository().AskFormUpload(modal).then((value) {
  //     print(jsonDecode(value.body));
  //     var body = AskFormModalClass.fromJson(jsonDecode(value.body));
  //     if (body.Status.toString() == "true") {
  //       Fluttertoast.showToast(msg: body.message).then((value) =>
  //           Navigator.push(context, MaterialPageRoute(builder: (context) {
  //             return Inquries();
  //           })));
  //     } else {
  //       Fluttertoast.showToast(msg: body.message);
  //     }
  //   });
  // }

  Future<void> sendData(String imageUrl, String url, String desc) async {
    //query id by getting during audio update and get id
    // user id also update in audio file uploading time
    String mUrl = BaseUrl + "query/update/${Shared.pref.getString("queryId")}";
    print("Update Profile URL--> $imageUrl");
    print("Update Profile NAME--> $url");
    print("Update Profile EMAIL--> $desc");

    Map<String, String> headers = {};
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(mUrl),
    );
    request.fields["user_id"] = Shared.pref.getString("userId").toString();

    request.fields["product_url"] = url;
    request.fields["description"] = desc;

    request.files
        .add(await http.MultipartFile.fromPath("query_image", imageUrl));

    headers = {"Content-type": "multipart/form-data"};
    request.headers.addAll(headers);
    var apiResponse = await request.send();
    //print("This is response: -> ${apiResponse.statusCode}");
    final responseString = await apiResponse.stream.bytesToString();

    // print("This is responseString: -> $responseString");
    Map<String, dynamic> response = json.decode(responseString);
    // print("This is responseString: -> $response");

    AskFormModalClass askFormModalClass = AskFormModalClass.fromJson(response);
    if (apiResponse.statusCode == 200) {
      // Loader.removeLoader(loader!);
      print("resp : ${response}");
      if (askFormModalClass.Status!) {
        // response.forEach((key, value) {
        //   print("$key : $value");
        //   if (value['data']) {
        //     print("yess");
        //   }
        //});
        //InquriesModalClass.fromJson(jsonDecode(response))
        setState(() {
          Navigator.push(context, MaterialPageRoute(builder: (cnt) {
            return Inquries();
          }));
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: orange,
          content: Text(
            askFormModalClass.message.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
      setState(() {});
    } else {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: orange,
          content: Text(
            askFormModalClass.message.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  Future getGallaryImage() async {
    pickedFile = await picker
        .getImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    )
        .then((value) {
      ImageUrl = value!.path;
      imagePath = File(ImageUrl!);
      setState(() {});
    });
    print(" my picker: $ImageUrl");
    print(" my picker imagePath: $imagePath");
    print(" my picker: $pickedFile");
    if (imagePath == null) {
      Fluttertoast.showToast(msg: "Image is not Selected");
    } else {
      Fluttertoast.showToast(msg: "Image is Selected");
    }
  }

  Widget LowerBody(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            getGallaryImage();
          },
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: orange,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              imagePath == null
                  ? InputField(
                      IsEnable: false,
                      // height: 60,
                      width: MediaQuery.of(context).size.width * 0.7,
                      keyboardType: TextInputType.text,
                      // onChanged: (val){},
                      IsBorder: true,
                      IsStyle: true,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: orange),
                      hint: 'Image Upload',
                    )
                  : Container(
                      margin: EdgeInsets.only(left: 8.0),
                      width: MediaQuery.of(context).size.width * 0.66,
                      height: 55.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Image.file(
                          imagePath!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            CircleAvatar(
              backgroundColor: orange,
              child: Image.asset("assets/images/url.png"),
            ),
            SizedBox(
              width: 20,
            ),
            InputField(
              // height: 60,
              error: isUrlError ? validationMessage : "",
              width: MediaQuery.of(context).size.width * 0.7,
              keyboardType: TextInputType.text,
              onChanged: (val) {
                setState(() {
                  Url = val;
                });
              },
              IsBorder: true,
              IsStyle: true,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 15, fontWeight: FontWeight.bold, color: orange),
              hint: 'URL',
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            CircleAvatar(
              backgroundColor: orange,
              child: Image.asset("assets/images/description.png"),
            ),
            SizedBox(
              width: 20,
            ),
            InputField(
              height: Description!.isEmpty
                  ? 60
                  : Description!.length.toDouble() < 40
                      ? Description!.length.toDouble() + 40
                      : Description!.length.toDouble(),
              // height: 60,
              width: MediaQuery.of(context).size.width * 0.7,
              keyboardType: TextInputType.text,
              onChanged: (val) {
                setState(() {
                  Description = val;
                });
              },
              IsBorder: true,
              IsStyle: true,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 15, fontWeight: FontWeight.bold, color: orange),
              hint: 'Description',
            )
          ],
        ),
        SizedBox(
          height: 100,
        ),
        Center(
          child: GestureDetector(
            onTap: () async {
              if (ImageUrl == null) {
                Fluttertoast.showToast(msg: "Please select photo");
              } else if (Url.isEmpty) {
                setState(() {
                  isUrlError = true;
                  validationMessage = "Please enter website URL.";
                });
              } else if (!RegExp(
                      "^www\.(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\.)+[a-z0-9][a-z0-9-]{0,61}[a-z0-9]")
                  .hasMatch(Url)) {
                setState(() {
                  isUrlError = true;
                  validationMessage = "Please Enter Valid URL, Start with WWW";
                });
              } else {
                isUrlError = false;
                Overlay.of(context)!.insert(loader!);
                setState(() {
                  sendData(ImageUrl!, Url, Description!);
                });
                Loader.hideLoader(loader!);
              }
            },
            child: ColorButton(
              width: MediaQuery.of(context).size.width * 0.6,
              RoundCorner: true,
              title: "Submit",
            ),
          ),
        )
      ],
    );
  }

  Widget UpperBody(BuildContext context) {
    height = AppBar().preferredSize.height;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      _key.currentState!.openDrawer();
                    },
                    child: Icon(
                      Icons.menu_rounded,
                      color: orange,
                    )),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                    'Your query has been submitted successfully. you can use below fields to get better results',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 13)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                iconColor: Colors.white,
                initiallyExpanded: true,
                title: Text(
                  'Additional Information',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: DarkBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                children: [LowerBody(context)],
              ),
            ),
            // SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    loader = Loader.overlayLoader(context);
    return Scaffold(
      key: _key,
      drawerEnableOpenDragGesture: false,
      drawer: drawer(),
      backgroundColor: white,
      body: Container(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          child: UpperBody(context)),
    );
  }
}

class Level {}
