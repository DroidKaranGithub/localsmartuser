import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:client_ajay_user_panel/ApiRepository/ApiRepository.dart';
import 'package:client_ajay_user_panel/ApiRepository/ApiRepository.dart';
import 'package:client_ajay_user_panel/Auth/Register/RegisterUserModalClass.dart';
import 'package:client_ajay_user_panel/ConstantDrawer.dart';
import 'package:client_ajay_user_panel/Constants/LoaderClass.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Ask/AskForm/AskForm.dart';
import 'package:client_ajay_user_panel/DashboardScreens/Ask/Recording/RecordingModalClass.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:client_ajay_user_panel/Constants/ColorButton.dart';
import 'package:client_ajay_user_panel/Constants/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';

///
typedef _Fn = void Function();

Future<String> _getTempPath(String path) async {
  var tempDir = await getTemporaryDirectory();
  var tempPath = tempDir.path;
  return tempPath + '/' + path;
}

/// Example app.
class Recording extends StatefulWidget {
  @override
  static String id = "Recording";

  _RecordingState createState() => _RecordingState();
}

class _RecordingState extends State<Recording> {
  String? UserId = Shared.pref.getString("UserID");
  OverlayEntry? loader;
  FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  bool a = false;
  // File file;
  // String? _mPath = "/storage/emulated/0";
  String? _mPath = "Audio";
  String? AudioList = "";
  String? AudioList2 = "";
  String? path2 = "";
  bool? AudioWave = false;
  double b = 0.0;
  int? counter;
  Timer? timer1;

  String _mPathAAC = '';
  String _mPathMP3 = '';
  starttimer() {
    counter = 30;
    timer1 = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (counter! > 0) {
          counter = counter! - 1;
        } else {
          a = false;
          stopRecorder();
          timer1!.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    _mPlayer.openAudioSession().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });

    openTheRecorder().then((value) {
      setState(() {
        _mRecorderIsInited = true;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _mPlayer.closeAudioSession();
    // _mPlayer = null;

    _mRecorder.closeAudioSession();
    // _mRecorder = null;
    super.dispose();
  }

  Future<void> openTheRecorder() async {
    _mPathAAC = await _getTempPath('flutter_sound_example.aac');
    _mPathMP3 = await _getTempPath('flutter_sound_example.mp3');

    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder.openAudioSession();
    _mRecorderIsInited = true;
  }

  // ----------------------  Here is the code for recording, convertFile(), and playback -------

  void record() async {
    var directory = await getApplicationDocumentsDirectory();
    _mPathAAC = directory.path +
        '/' +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.aac';
    debugPrint("PATH-->--> $_mPathAAC");
    _mRecorder
        .startRecorder(
      toFile: _mPathAAC,
    )
        .then((value) {
      setState(() {});
    });
  }

  void stopRecorder() async {
    await _mRecorder.stopRecorder().then((value) {
      setState(() {
        //var url = value;
        _mplaybackReady = true;
      });

      AudioList = value;
    });
  }

  Future<void> play() async {
    assert(_mPlayerIsInited &&
        _mplaybackReady &&
        _mRecorder.isStopped &&
        _mPlayer.isStopped);

    await FlutterSoundHelper()
        .convertFile(_mPathAAC, Codec.aacADTS, _mPathMP3, Codec.mp3);
    await _mPlayer.startPlayer(
        codec: Codec.mp3,
        fromURI: _mPathMP3,
        whenFinished: () {
          setState(() {});
        });
    setState(() {});
    print(_mPathMP3);
    // Upload("48", _mPathMP3);
    print('helooooooooooooooooooooooooooooooo');
  }

  Future<void> play3() async {
    await FlutterSoundHelper()
        .convertFile(_mPathAAC, Codec.aacADTS, _mPathMP3, Codec.mp3);

    setState(() {});
    print(_mPathMP3);
    print(Shared.pref.getInt("userPerticulaId"));
    Upload(Shared.pref.getInt("userPerticulaId").toString(), _mPathMP3);
    print('helooooooooooooooooooooooooooooooo');
  }

  Upload(String userid, String path) {
    print(path);
    print('hereeeeeee $userid');
    ApiRepository().RecordingUploader(userid, path).then((value) {
      print("RESPONSE--> ${value.userId}");
      print("RESPONSE--> ${value.queryId}");
      Shared.pref.setString("userId", value.userId.toString());
      Shared.pref.setString("queryId", value.queryId.toString());
      if (value.status.toString() == "true") {
        Fluttertoast.showToast(msg: value.message).then((value) =>
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AskForm();
            })));
      } else {
        Fluttertoast.showToast(msg: value.message);
      }
    });
  }

  void stopPlayer() {
    _mPlayer.stopPlayer().then((value) {
      setState(() {});
    });
  }

// ----------------------------- UI --------------------------------------------

  _Fn? getRecorderFn() {
    if (!_mRecorderIsInited || !_mPlayer.isStopped) {
      return null;
    }
    return _mRecorder.isStopped ? record : stopRecorder;
  }

  _Fn? getPlaybackFn() {
    if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder.isStopped) {
      return null;
    }
    print('playyyyyyyyyyyyyyyyyy');
    return _mPlayer.isStopped ? play : stopPlayer;
  }

  Widget Body(BuildContext context) {
    loader = Loader.overlayLoader(context);
    height = AppBar().preferredSize.height;
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      key: _key,
      drawer: drawer(),
      backgroundColor: white,
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
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
                      // CircleAvatar(
                      //   radius: 40,
                      //   backgroundColor: orange,
                      //   child: Text('ASK',style: Theme.of(context).textTheme.headline1!.copyWith(
                      //       color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold
                      //   ),),
                      // ),
                      // SizedBox(width: 20,)
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: a == false ? true : false,
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            starttimer();
                            AudioList = "";
                            a = true;
                            record();
                            // _controller.start();
                          });
                        },
                        child: Icon(
                          Icons.mic,
                          color: DarkBlue,
                          size: 150,
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: AudioList!.isEmpty ? false : true,
                    child: InkWell(
                        onTap: () {
                          if (_mPlayer.isStopped) {
                            getPlaybackFn();
                          }
                          if (_mPlayer.isPlaying) {
                            stopPlayer();
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Blue,
                              borderRadius: BorderRadius.circular(30)),
                          child: ElevatedButton(
                            onPressed: getPlaybackFn(),
                            //color: Colors.white,
                            //disabledColor: Colors.grey,
                            child: Icon(
                              _mPlayer.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                              size: 40,
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              primary: Blue,
                            ),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Visibility(
                    visible: a == true ? true : false,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Blue,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          counter == null
                              ? ""
                              : '00: ${counter! < 10 ? "0$counter" : counter} Sec',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: a == true ? true : false,
                    child: GestureDetector(
                      onTap: () {
                        //Navigator.pop(context);
                        setState(() {
                          timer1!.cancel();
                          a = false;
                          stopRecorder();
                        });
                      },
                      child: Card(
                        color: orange,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Stop",
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Visibility(
                  //     visible:a==false?false:true,
                  //     child: Center(child: Container(
                  //         height: 100,
                  //         child: Lottie.asset("assets/animation/mic.json",)),)),
                ],
              ),
              Column(
                children: [
                  // SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () {
                      // Overlay.of(context)!.insert(loader!);
                      play3();
                      Loader.hideLoader(loader!);
                      setState(() {});
                    },
                    child: ColorButton(
                      width: MediaQuery.of(context).size.width * 0.5,
                      RoundCorner: true,
                      // color: orange,
                      title: "Next",
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  var height;
  @override
  Widget build(BuildContext context) {
    height = AppBar().preferredSize.height;
    return Body(context);
  }
}
