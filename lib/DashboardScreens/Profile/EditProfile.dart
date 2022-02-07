import 'dart:convert';
import 'dart:io';

import 'package:client_ajay_user_panel/Constants/ColorButton.dart';
import 'package:client_ajay_user_panel/Constants/Constant.dart';
import 'package:client_ajay_user_panel/Constants/InputField.dart';
import 'package:client_ajay_user_panel/Constants/LoaderClass.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Profile/Model/profile_update_response.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as http_parser;

class EditProfile extends StatefulWidget {
  static String id = "EditProfile";
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isNameError = false;
  String validationMessage = "";
  OverlayEntry? loader;
  String? Email = '';
  String? Name = '';
  String mEmail = '';
  String mName = '';
  bool isFromWeb = true;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegExp phoneRegex = new RegExp(r'^[6-9]\d{9}$');
  final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  ProfileUpdateResponse profileUpdateResponse = ProfileUpdateResponse();

  @override
  void initState() {
    print("Init");
    print("Init-> ${Shared.pref.getString("NAME")}");
    mName = Shared.pref.getString("NAME") == null
        ? ""
        : Shared.pref.getString("NAME") == "null"
            ? ""
            : Shared.pref.getString("NAME")!;
    mEmail = Shared.pref.getString("EMAIL") == null
        ? ""
        : Shared.pref.getString("EMAIL")!;
    super.initState();
  }

  Future<void> _updateProfile() async {
    String mUrl = BaseUrl + "profile/update";
    print("Update Profile USER_ID--> ${Shared.pref.getString("USER_ID")!}");
    print("Update Profile URL--> $mUrl");
    print("Update Profile NAME--> $mName");
    print("Update Profile EMAIL--> $mEmail");

    Map<String, String> headers = {};
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(mUrl),
    );
    request.fields["user_id"] = Shared.pref.getString("USER_ID")!;
    request.fields["name"] = mName;
    if (mEmail.isNotEmpty) {
      request.fields["email"] = mEmail;
    }

    if (profileImagePath != null)
      request.files.add(await http.MultipartFile.fromPath(
          "profile_image", profileImagePath!,
          contentType: http_parser.MediaType('profile_image', 'jpeg')));

    headers = {"Content-type": "multipart/form-data"};
    debugPrint("REQUEST--> ${request.fields}");
    debugPrint("REQUEST--> ${request.files}");
    request.headers.addAll(headers);
    var apiResponse = await request.send();
    print("This is response: -> ${apiResponse.statusCode}");
    final responseString = await apiResponse.stream.bytesToString();

    print("This is responseString: -> $responseString");
    Map<String, dynamic> response = json.decode(responseString);
    print("This is responseString: -> $response");

    profileUpdateResponse = ProfileUpdateResponse.fromJson(response);
    if (apiResponse.statusCode == 200) {
      Loader.removeLoader(loader!);

      if (profileUpdateResponse.status!) {
        savePref().whenComplete(() {
          Navigator.pop(context);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: orange,
            content: Text(
              profileUpdateResponse.message.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }
    } else {
      Loader.removeLoader(loader!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: orange,
          content: Text(
            profileUpdateResponse.message.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  Future<void> savePref() async {
    debugPrint("IMAGE-->${profileUpdateResponse.data!.profileImage}");
    Shared.pref.setString("NAME", profileUpdateResponse.data!.name!);
    if (profileUpdateResponse.data!.email != null) {
      Shared.pref.setString("EMAIL", profileUpdateResponse.data!.email!);
    }
    Shared.pref.setString(
        "PROFILE_IMAGE",
        profileUpdateResponse.data!.profileImage != null
            ? profileUpdateResponse.data!.profileImage!
            : "");
    debugPrint(
        "IMAGE_PROFILE_IMAGE-->${Shared.pref.getString("PROFILE_IMAGE")}");
  }

  @override
  Widget build(BuildContext context) {
    Name = Shared.pref.getString("NAME") == null
        ? ""
        : Shared.pref.getString("NAME")!;
    Email = Shared.pref.getString("EMAIL") == null
        ? ""
        : Shared.pref.getString("EMAIL")!;
    print("PROFILE_IMAGE--> ${Shared.pref.getString("USER_ID")!}");
    // print("PROFILE_IMAGE--> ${Shared.pref.getString("PROFILE_IMAGE")!}");
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
                              child: isFromWeb
                                  ? Shared.pref.getString("PROFILE_IMAGE") ==
                                          "null"
                                      ? Icon(
                                          Icons.person,
                                          size: 30,
                                          color: Colors.white,
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          child: Image.network(
                                            Shared.pref
                                                .getString("PROFILE_IMAGE")!,
                                            fit: BoxFit.cover,
                                          ))
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.file(
                                        profileImageFile!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                _imagePicker();
                              },
                              child: Text(
                                "Change Picture",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: orange),
                              ),
                            )
                          ],
                        ),
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 30,
                        )
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
                            'Name',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: orange,
                                    fontSize: 20),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InputField(
                            initialValue: mName,
                            onChanged: (val) {
                              // setState(() {
                              Name = val;
                              mName = val;
                              // });
                            },
                            width: MediaQuery.of(context).size.width * 0.62,
                            validator: (value) {
                              if (value == null) {
                                return "Enter Name";
                              } else if (value.isEmpty) {
                                return "Enter Name";
                              } else {
                                Name = value;
                                mName = value;
                              }
                            },
                            keyboardType: TextInputType.text,
                            IsBorder: true,
                            hint: 'Name',
                            error: isNameError ? validationMessage : "",
                            IsStyle: true,
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: orange.withOpacity(0.5),
                                    fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
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
                          InputField(
                            initialValue: mEmail,
                            onChanged: (val) {
                              // setState(() {
                              print("EMail val---> $val");
                              Email = val;
                              mEmail = val;
                              print("EMail EMAIL---> $Email");
                              // });
                            },
                            width: MediaQuery.of(context).size.width * 0.62,
                            validator: (value) {
                              // if (value == null) {
                              //   return "Enter Email";
                              // } else if (value.isEmpty) {
                              //   return "Enter Email";
                              // } else if (!emailRegex.hasMatch(value)) {
                              //   return 'Please Enter valid Email';
                              // } else {
                              Email = value;
                              mEmail = value;
                              // }
                            },
                            keyboardType: TextInputType.emailAddress,
                            IsBorder: true,
                            hint: 'Email',
                            IsStyle: true,
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: orange.withOpacity(0.5),
                                    fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Contact',
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
                            height: 60,
                            decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(20)),
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                Shared.pref.getString("PHONE")!,
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
                            height: 60,
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
                        onTap: () {
                          if (mName.isEmpty) {
                            isNameError = true;
                            validationMessage = "Please enter name";
                            setState(() {});
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(
                            //     backgroundColor: orange,
                            //     content: Text(
                            //       "Please enter name",
                            //       style: TextStyle(color: Colors.white),
                            //     ),
                            //   ),
                            // );
                          } else {
                            isNameError = false;
                            Overlay.of(context)!.insert(loader!);

                            _updateProfile();
                          }
                        },
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

  void _imagePicker() {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return Material(
            type: MaterialType.transparency,
            child: Center(
              child: Container(
                margin: EdgeInsets.only(left: 16.0, right: 16.0),
                width: MediaQuery.of(context).size.width * 0.6,
                height: 120.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Select image from",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontFamily: 'LATO',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20.0,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 30.0),
                        ),
                        IconButton(
                          onPressed: () => _imagePickerFromCamera(),
                          icon: Icon(
                            Icons.camera_alt_rounded,
                            size: 50.0,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () => _imagePickerFromGallery(),
                          icon: Icon(
                            Icons.image_outlined,
                            size: 50.0,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 50.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  String? profileImagePath;
  File? profileImageFile;
  void _imagePickerFromCamera() async {
    var imageCamera = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      if (imageCamera!.path.isNotEmpty) {
        profileImagePath = imageCamera.path;
        print("PROFILE_PATH --> ${imageCamera.path}");
        print("PROFILE_PATH --> $profileImagePath");
        profileImageFile = File(imageCamera.path);
      }
      setState(() {
        isFromWeb = false;
      });

      Navigator.of(context).pop();
    });
  }

  void _imagePickerFromGallery() async {
    var imageGallery = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100);
    setState(() {
      if (imageGallery!.path.isNotEmpty) {
        profileImagePath = imageGallery.path;
        print("PROFILE_PATH --> ${imageGallery.path}");
        print("PROFILE_PATH --> $profileImagePath");
        profileImageFile = File(imageGallery.path);
      }
      setState(() {
        isFromWeb = false;
      });

      Navigator.of(context).pop();
    });
  }
}
