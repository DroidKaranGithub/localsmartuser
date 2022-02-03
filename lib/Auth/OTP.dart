// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:client_ajay_user_panel/ApiRepository/ApiRepository.dart';
import 'package:client_ajay_user_panel/Auth/Register/RegisterOTPModalClass.dart';
import 'package:client_ajay_user_panel/Auth/Register/RegisterUserModalClass.dart';
import 'package:client_ajay_user_panel/Constants/ColorButton.dart';
import 'package:client_ajay_user_panel/Constants/Constant.dart';
import 'package:client_ajay_user_panel/Constants/InputField.dart';
import 'package:client_ajay_user_panel/Constants/LoaderClass.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Ask/Ask.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_autofill/otp_autofill.dart';

class OTP extends StatefulWidget {
  String? Name;
  String? Email;
  String? Mobile = "";
  String? OtpCode;
  OTP({this.Mobile, this.Email, this.Name, this.OtpCode});

  static String id = "OTP";
  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  String? Name;
  String? Email;
  String? Mobile;
  String? phone;
  String? code;
  String? msg;
  bool isOtpError = false;
  String validationMessage = "";
  late OverlayEntry? loader;
  String? EnteredOtp;
  final scaffoldKey = GlobalKey();
  late OTPTextEditController controller;
  late OTPInteractor _otpInteractor;
  Color color = orange;
  TextEditingController Textcontroller = TextEditingController();

  void initState() {
    super.initState();
    _otpInteractor = OTPInteractor();
    _otpInteractor
        .getAppSignature()
        .then((value) => print('signature - $value'));

    controller = OTPTextEditController(
      codeLength: 6,
      //ignore: avoid_print
      onCodeReceive: (code) => print('Your Application receive code - $code'),
      otpInteractor: _otpInteractor,
    )..startListenUserConsent(
        (code) {
          final exp = RegExp(r'(\d{6})');
          return exp.stringMatch(code ?? '') ?? '';
        },
        // strategies: [
        //   SampleStrategy(),
        // ],
      );
  }

  @override
  void dispose() {
    controller.stopListen();
    super.dispose();
  }

  // register(Map<String, dynamic> modal) async {
  //   print("modal $modal");

  //   ApiRepository().RegisterOTPVerification(modal).then((value) {
  //     var msg = jsonDecode(value.body);
  //     print(msg);
  //     // Fluttertoast.showToast(
  //     //   msg: msg['msg'],
  //     // );
  //     ApiRepository()
  //         .Register(
  //             RegisterUserModalClass(Name: widget.Name, Mobile: widget.Mobile)
  //                 .toJson())
  //         .then((value) {
  //       var msg = jsonDecode(value.body);
  //       print(value.body);
  //       print(value.statusCode);
  //       var body = LoginModalClass.fromJson(jsonDecode(value.body));
  //       var body1 = LoginModalClass.fromJson(jsonDecode(value.body)).user;
  //       if (value.statusCode == 200 && body.Status == true) {
  //         Shared.pref.setInt("userPerticularId", int.parse(body1!.id!));
  //         Shared.pref.setString("UserName", body1.name.toString());
  //         Shared.pref.setString("mobileNumber", body1.phone.toString());
  //         Shared.pref.setBool("Login", true);
  //         Navigator.pushReplacement(context,
  //             MaterialPageRoute(builder: (context) {
  //           return Ask();
  //         }));
  //       } else {
  //         Fluttertoast.showToast(
  //             msg: "${msg['message']} Please login",
  //             backgroundColor: Colors.red,
  //             textColor: Colors.white,
  //             toastLength: Toast.LENGTH_SHORT,
  //             fontSize: 16);

  //         Future.delayed(Duration(milliseconds: 600)).then((value) => {
  //               Navigator.push(context, MaterialPageRoute(builder: (cnt) {
  //                 return Login();
  //               }))
  //             });
  //       }
  //     });
  //   });
  // }

  register(Map<String, dynamic> modal) async {
    print("modal $modal");

    ApiRepository().RegisterOTPVerification(modal).then((value) {
      var msg = jsonDecode(value.body);
      print("msg $msg");
      if (msg['status'] == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              msg['error'],
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
        // Fluttertoast.showToast(
        //   msg: msg['error'],

        // );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              msg['msg'],
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
        // Fluttertoast.showToast(
        //   msg: msg['msg'],
        // );
        ApiRepository()
            .Register(
                RegisterUserModalClass(Name: widget.Name, Mobile: widget.Mobile)
                    .toJson())
            .then((value) {
          var msg = jsonDecode(value.body);
          print(value.body);
          print(value.statusCode);
          if (value.statusCode == 200) {
            // Fluttertoast.showToast(msg: msg['message']);
            Shared.pref.setBool("Login", true);
            Shared.pref.setInt(
                "userParticulaId", int.parse(msg['data']['id'].toString()));
            debugPrint(
                "userParticulaId-->${Shared.pref.getInt("userParticulaId")}");

            Shared.pref.setString("USER_ID", msg['data']['id'].toString());
            debugPrint("USER_ID-->${Shared.pref.getString("USER_ID")}");
            // Shared.pref.setInt(
            //     "userPerticularId", int.parse(msg['data']['id']).toInt());
            Shared.pref.setString("UserName", msg['data']['name'].toString());
            Shared.pref
                .setString("mobileNumber", msg['data']['phone'].toString());
            Shared.pref.setString("NAME", msg['data']['name'].toString());
            Shared.pref.setString("PHONE", msg['data']['phone'].toString());

            Shared.pref.setString(
                "wallet_balance", msg['data']['wallet_balance'].toString());

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return Ask();
            }));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  msg['message'],
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
            // Fluttertoast.showToast(msg: msg['message']);
          }
        });
      }
    });
    // var otp = jsonDecode(result.body);
    // print("final vendor register ${result.body}");
    // var resultData = await ApiRepository()
    //     .RegisterOTPVerification({"phone": modal['phone'], "otp": otp['otp']});
    // print("final verification ${resultData.body}");
    // var res = result;
    // if (res['code'].toString() == "200") {
    //   // Shared.pref.setBool("Login", true);
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    //     return Ask();
    //   }));
    // } else {
    //   Fluttertoast.showToast(msg: res['msg']);
    // }
    // // print("myResult > ${res['code']}");
  }

  resendOtp(Map<String, dynamic> modal) {
    ApiRepository().ResendOtp(modal).then((value) {
      print(value.body);
      var msg = jsonDecode(value.body);

      if (msg['code'] == 200) {
        Fluttertoast.showToast(
            msg: "${msg['msg']} OTP : ${msg['otp']}",
            toastLength: Toast.LENGTH_LONG);
        setState(() {
          widget.OtpCode = msg['otp'].toString();
        });
      } else {
        Fluttertoast.showToast(msg: "${msg['msg']}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    loader = Loader.overlayLoader(context);
    var height = AppBar().preferredSize.height;
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: height,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            'assets/images/otparrow.png',
                            scale: 1.2,
                          ))
                    ],
                  ),
                  Image.asset(
                    'assets/images/otp.png',
                    scale: 1.2,
                  )
                ],
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
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Verification Code',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: color,
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'We have sent the code verification to Your Mobile Number',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: color,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.Mobile!,
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: color),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.edit,
                                size: 20,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InputField(
                        controller: controller,
                        hint: 'Enter OTP',
                        align: TextAlign.center,
                        keyboardType: TextInputType.phone,
                        maxLength: 6,
                        IsStyle: true,
                        error: isOtpError ? validationMessage : "",
                        fillColor: Colors.white,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: color,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        IsBorder: true,
                        width: MediaQuery.of(context).size.width * 0.6,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          print("verify ${widget.OtpCode.toString()}");

                          setState(() {
                            if (controller.text.toString().isEmpty) {
                              isOtpError = true;
                              validationMessage = "Please enter otp";
                            } else {
                              isOtpError = false;
                              Overlay.of(context)!.insert(loader!);
                              register(RegisterOTPModalClass(
                                      phone: widget.Mobile,
                                      Otp: controller.text)
                                  .toJson());
                              Loader.hideLoader(loader!);
                            }
                          });
                          // 1 regiter 2 login 3 resend
                        },
                        child: ColorButton(
                          RoundCorner: true,
                          width: 200,
                          // color: color,
                          title: 'Verify',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          print(widget.OtpCode.toString());
                          setState(() {
                            isOtpError = false;
                          });
                          resendOtp({
                            "phone": widget.Mobile,
                            "otp": widget.OtpCode.toString(),
                            "type": "3"
                          });
                        },
                        child: Text(
                          'Resend OTP',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  color: Blue,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
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
