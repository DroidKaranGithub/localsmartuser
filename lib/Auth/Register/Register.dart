import 'dart:convert';

import 'package:client_ajay_user_panel/ApiRepository/ApiRepository.dart';
import 'package:client_ajay_user_panel/Auth/OTP.dart';
import 'package:client_ajay_user_panel/Auth/Register/RegisterOTPModalClass.dart';
import 'package:client_ajay_user_panel/Auth/Register/RegisterUserModalClass.dart';
import 'package:client_ajay_user_panel/Constants/ColorButton.dart';
import 'package:client_ajay_user_panel/Constants/Constant.dart';
import 'package:client_ajay_user_panel/Constants/InputField.dart';
import 'package:client_ajay_user_panel/Constants/LoaderClass.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Ask/Ask.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  static String id = "Register";

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? Name;
  String? Email;
  String? Mobile;
  String? Otp;
  bool isNameError = false;
  bool isContactError = false;
  String validationMessage = "";
  late OverlayEntry loader;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegExp phoneRegex = new RegExp(r'^[6-9]\d{9}$');
  final RegExp emailRegex = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  GetOtp(Object modal) {
    print(modal);
    ApiRepository().RegisterOTPVerification(modal).then((value) {
      print("Response register-->${jsonDecode(value.body)}");
      var msg = jsonDecode(value.body);
      var body = RegisterOTPModalClass.fromJson(jsonDecode(value.body));

      print("body data ${body.Msg} ${body.Otp}");
      if (msg['status'] == false) {
        // Fluttertoast.showToast(
        //     msg: "${body.Msg.toString()}", toastLength: Toast.LENGTH_LONG);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              msg['error'],
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
        // Navigator.pop(context);
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return OTP(
            Name: Name,
            Mobile: Mobile,
            //  Email: Email,
            OtpCode: body.Otp.toString(),
          );
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    loader = Loader.overlayLoader(context);
    var height = AppBar().preferredSize.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height,
                      ),
                      Center(
                        child: Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  color: DarkBlue,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
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
                          // SizedBox(width: 20,),
                          InputField(
                            onChanged: (val) {
                              setState(() {
                                Name = val;
                              });
                            },
                            width: MediaQuery.of(context).size.width * 0.7,
                            validator: (value) {
                              if (value == null) {
                                return "Enter Name";
                              } else if (value.isEmpty) {
                                return "Enter Name";
                              }
                            },
                            keyboardType: TextInputType.text,
                            error: isNameError ? validationMessage : "",
                            IsBorder: true,
                            hint: 'Name',
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
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //   Text('Email',style: Theme.of(context).textTheme.headline1!.copyWith(
                      //       fontWeight: FontWeight.bold,color: orange,fontSize: 20
                      //   ),),
                      //  // SizedBox(width: 20,),
                      //   InputField(
                      //     onChanged: (val){

                      //       setState(() {
                      //         Email=val;
                      //       });
                      //     },
                      //     width: MediaQuery.of(context).size.width*0.7,
                      //     validator:(value){
                      //       if(value==null){
                      //         return "Enter Email";
                      //       }
                      //       else if(value.isEmpty){
                      //         return "Enter Email";
                      //       }
                      //      else if (!emailRegex.hasMatch(value)) {
                      //         return 'Please Enter valid Email';
                      //       }
                      //       },
                      //     keyboardType: TextInputType.emailAddress,
                      //     IsBorder: true,
                      //     hint: 'Email',
                      //     IsStyle: true,
                      //     style: Theme.of(context).textTheme.headline1!.copyWith(
                      //         fontWeight: FontWeight.bold,color: orange.withOpacity(0.5),fontSize:16),
                      //   ),
                      // ],),
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
                          InputField(
                            onChanged: (val) {
                              setState(() {
                                Mobile = val;
                              });
                            },
                            width: MediaQuery.of(context).size.width * 0.7,
                            validator: (value) {
                              if (value == null) {
                                return "Enter Mobile Number";
                              } else if (value.isEmpty) {
                                return "Enter Mobile Number";
                              } else if (!phoneRegex.hasMatch(value)) {
                                return 'Please Enter valid phone number';
                              }
                            },
                            error: isContactError ? validationMessage : "",
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            IsBorder: true,
                            hint: 'Contact',
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
                        height: 50,
                      ),

                      InkWell(
                        onTap: () {
                          // if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();

                          // GetOtp(RegisterUserModalClass(
                          //   Mobile: Mobile,
                          //   // Email: Email,
                          //   Name: Name,
                          // ).toJson());
                          setState(() {
                            if (Name == null) {
                              isNameError = true;
                              validationMessage = "Enter Name";
                            } else if (Name!.isEmpty) {
                              isNameError = true;
                              validationMessage = "Enter Name";
                            } else if (Mobile == null) {
                              isNameError = false;
                              isContactError = true;
                              validationMessage = "Enter Mobile Number";
                            } else if (Mobile!.isEmpty) {
                              isNameError = false;
                              isContactError = true;
                              validationMessage = "Enter Mobile Number";
                            } else if (!phoneRegex.hasMatch(Mobile!)) {
                              isNameError = false;
                              isContactError = true;
                              validationMessage =
                                  'Please Enter valid phone number';
                            } else {
                              isNameError = false;
                              isContactError = false;
                              Overlay.of(context)!.insert(loader);
                              GetOtp({
                                "phone": Mobile,
                                "type": "1",
                                "role_id": "3"
                              });
                              Loader.hideLoader(loader);
                            }
                          });

                          // }
                          // Navigator.push(context, MaterialPageRoute(builder: (context){
                          //   return OTP();
                          // }));
                        },
                        child: ColorButton(
                          RoundCorner: true,
                          width: 200,
                          // color: color,
                          title: 'Register',
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
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
