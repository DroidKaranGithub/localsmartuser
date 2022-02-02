import 'dart:convert';
import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:client_ajay_user_panel/ApiRepository/ApiRepository.dart';
import 'package:client_ajay_user_panel/ConstantDrawer.dart';
import 'package:client_ajay_user_panel/Constants/Constant.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Ask/Ask.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Inquries/InquriesModalClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:audioplayers/audioplayers.dart';
import '../Responses/Responses.dart';

class Inquries extends StatefulWidget {
  static String id = "Inquries";
  @override
  _InquriesState createState() => _InquriesState();
}

class _InquriesState extends State<Inquries> {
//  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);

  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  bool? IsPlaying;
  var prev1;
  List AudioValue = [];
  var AudioValueData;
  bool noInquries = false;
  String? UserId = Shared.pref.getInt("userParticulaId").toString();
  String? StatusCode;

  Color selected = orange;
  Color unSelected = Colors.white;
  Color TextSelected = Colors.white;
  Color TextunSelected = orange;
  int Selected = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  List Button = ['All', 'Active', 'Completed', 'On Hold'];

  List Date = [];
  List ResponseCount = [];
  List Category = [];
  List Id = [];
  List Title = [];
  List Status = [];
  List AudioList = [];

  // List ItemName=['ELECTORNICS','FURNITURE'];
  getData(int id) {
    print("user id is $id");
    ApiRepository().GetInquries(id).then((value) {
      //  log(value.body);

      var body = InquriesModalClass.fromJson(jsonDecode(value.body));
      // StatusCode = body.status.toString();
      //print(StatusCode);
      setState(() {});
      if (body.status == true) {
        var body1 = InquriesModalClass.fromJson(jsonDecode(value.body)).data;

        print("body data $body1");
        body1?.forEach((element) {
          AudioList.add(element.file!.filePath);
          AudioList.forEach((element) {
            AudioValue.add(false);
          });
          Id.add(element.id);
          Title.add(element.title);
          Status.add(element.status);
          Date.add(element.date!);
          Category.add(element.category);
          ResponseCount.add(element.response_count.toString());
        });
      } else {
        print("hello no inquries");
        setState(() {
          noInquries = true;
        });
      }

      print("id list $Id");
      print("titles $Title");
      print("Status $Status");
      print("Dates $Date");
      print("Category $Category");
      print("response count $ResponseCount");
      print("AudioFiles $AudioList");
    });
  }

  void initState() {
    super.initState();
    // getData(UserId!.toInt());

    getData(int.parse(Shared.pref.getInt("userPerticulaId").toString()));
    print(Shared.pref.getInt("userPerticulaId").toString());
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
              'Inquiries',
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
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Selected = 0;
                  setState(() {});
                },
                child: Card(
                  elevation: 10,
                  child: Container(
                    // height: 20,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Selected == 0 ? selected : unSelected,
                        borderRadius: BorderRadius.circular(5)),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        Button[0],
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color:
                                Selected == 0 ? TextSelected : TextunSelected,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Selected = 1;
                  setState(() {});
                },
                child: Card(
                  elevation: 10,
                  child: Container(
                    // height: 20,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Selected == 1 ? selected : unSelected,
                        borderRadius: BorderRadius.circular(5)),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        Button[1],
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color:
                                Selected == 1 ? TextSelected : TextunSelected,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Selected = 3;
                  setState(() {});
                },
                child: Card(
                  elevation: 10,
                  child: Container(
                    // height: 20,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Selected == 3 ? selected : unSelected,
                        borderRadius: BorderRadius.circular(5)),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        Button[3],
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color:
                                Selected == 3 ? TextSelected : TextunSelected,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Selected = 2;
                  setState(() {});
                },
                child: Card(
                  elevation: 10,
                  child: Container(
                    // height: 20,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Selected == 2 ? selected : unSelected,
                        borderRadius: BorderRadius.circular(5)),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        Button[2],
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color:
                                Selected == 2 ? TextSelected : TextunSelected,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget LowerBody(BuildContext context) {
    var height = AppBar().preferredSize.height;
    return Expanded(
      child: noInquries
          ? Center(
              child: Text("No Inquiries Found",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)))
          : ListView.builder(
              itemCount: Id.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print(Title[index]);
                    Shared.pref.setString("title", Title[index]);
                    if (ResponseCount[index].toString() == "0") {
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Responses(
                          QueryId: int.parse(Id[index]),
                        );
                      }));
                    }
                  },
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      Column(
                        children: [
                          Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Visibility(
                                            visible: Title[index] == "null"
                                                ? false
                                                : true,
                                            child: Text(
                                              'Title: ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                            ),
                                          ),
                                          Visibility(
                                            visible: Title[index] == "null"
                                                ? false
                                                : true,
                                            child: Text(
                                              Title[index] ?? "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1!
                                                  .copyWith(
                                                      color:
                                                          Title[index] == "null"
                                                              ? Blue
                                                              : orange,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Date Posted: ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                          ),
                                          Text(
                                            Date[index],
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Visibility(
                                        visible: true,
                                        child: Row(
                                          children: [
                                            Text(
                                              'Responses: ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1!
                                                  .copyWith(
                                                      color: Blue,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                            ),
                                            Text(
                                              (int.parse(ResponseCount[
                                                          index]) ==
                                                      0)
                                                  ? "In Review"
                                                  : ResponseCount[index],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1!
                                                  .copyWith(
                                                      color: Blue,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                      onTap: AudioList[index] == null
                                          ? () {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Audio file is not available");
                                            }
                                          : () async {
                                              print(AudioList[index]);

                                              // try {
                                              //   if (AudioList[index] == false) {
                                              //     await assetsAudioPlayer
                                              //         .open(Audio.network(
                                              //             AudioList[index]))
                                              //         .then((value) {
                                              //       setState(() {
                                              //         assetsAudioPlayer.play();
                                              //         AudioList[index] = true;
                                              //       });
                                              //     });
                                              //   } else {
                                              //     setState(() {
                                              //       assetsAudioPlayer.stop();
                                              //       AudioList[index] = false;
                                              //     });
                                              //   }
                                              // } catch (e) {
                                              //   print("gets error");
                                              // }

                                              // audioPlayer
                                              //     .play(AudioList[index].toString());
                                              if (IsPlaying == true) {
                                                print("if");
                                                if (index == prev1) {
                                                  print("second if");
                                                  if (IsPlaying == true) {
                                                    print("second if if");
                                                    assetsAudioPlayer.stop();
                                                    AudioValue[index] = false;
                                                    prev1 = index;
                                                    IsPlaying = false;
                                                    setState(() {});
                                                  } else {
                                                    print("second if else");
                                                    AudioValue[index] = true;
                                                    prev1 = index;
                                                    IsPlaying = true;
                                                    assetsAudioPlayer
                                                        .open(Audio.network(
                                                            (AudioList[index])))
                                                        .then((value) {
                                                      assetsAudioPlayer
                                                          .playlistFinished
                                                          .listen((event) {
                                                        if (event == true) {
                                                          setState(() {
                                                            AudioValue[index] =
                                                                false;
                                                            prev1 = index;
                                                            IsPlaying = false;
                                                          });
                                                        }
                                                      });
                                                    });
                                                    setState(() {});
                                                  }
                                                } else {
                                                  print("if else");
                                                  AudioValue[index] = true;
                                                  AudioValue[prev1] = false;
                                                  prev1 = index;
                                                  assetsAudioPlayer
                                                      .open(Audio.network(
                                                          AudioList[index]))
                                                      .then((value) {
                                                    assetsAudioPlayer
                                                        .playlistFinished
                                                        .listen((event) {
                                                      if (event == true) {
                                                        setState(() {
                                                          AudioValue[index] =
                                                              false;
                                                          prev1 = index;
                                                          IsPlaying = false;
                                                        });
                                                      }
                                                    });
                                                  });
                                                  setState(() {});
                                                }
                                              } else {
                                                print('else');
                                                IsPlaying = true;
                                                AudioValue[index] = true;
                                                prev1 = index;

                                                print(
                                                    "data is $IsPlaying  $AudioValue $prev1");

                                                assetsAudioPlayer
                                                    .open(
                                                  Audio.network(
                                                      (AudioList[index])),
                                                )
                                                    .then((value) {
                                                  assetsAudioPlayer
                                                      .playlistFinished
                                                      .listen((event) {
                                                    if (event == true) {
                                                      setState(() {
                                                        AudioValue[index] =
                                                            false;
                                                        prev1 = index;
                                                        IsPlaying = false;
                                                      });
                                                    }
                                                  });
                                                });
                                                setState(() {});
                                              }
                                            },
                                      child: AudioValue[index] == true
                                          ? CircleAvatar(
                                              backgroundColor: orange,
                                              child: Icon(
                                                Icons.pause,
                                                color: Colors.white,
                                              ),
                                            )
                                          : Image.asset(
                                              "assets/images/play.png"))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Category[index] == null ? 30 : 50,
                          ),
                        ],
                      ),
                      Visibility(
                        visible:
                            Category[index].toString() == "null" ? false : true,
                        child: Positioned(
                          top: Category[index].toString() == "null"
                              ? MediaQuery.of(context).size.height * 0.075
                              : MediaQuery.of(context).size.height * 0.095,
                          right: 70,
                          left: 70,
                          child: Container(
                            width: 130,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Blue,
                                borderRadius: BorderRadius.circular(6)),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Center(
                                child: Text(
                                  "${Category[index]}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = AppBar().preferredSize.height;
    return WillPopScope(
      onWillPop: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Ask();
        }));
        return Future<bool>.value(true);
      },
      child: Scaffold(
        drawer: drawer(),
        drawerEnableOpenDragGesture: false,
        key: _key,
        backgroundColor: Colors.white,
        body: Container(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            child:
                //  StatusCode == "true"
                //     ?
                Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [UpperBody(context), LowerBody(context)],
              ),
            )
            // : Center(
            //     child: CircularProgressIndicator(),
            //   ),
            ),
      ),
    );
  }
}
