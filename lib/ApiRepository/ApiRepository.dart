// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:client_ajay_user_panel/DashboardScreens/Ask/Recording/RecordingModalClass.dart';
import 'package:client_ajay_user_panel/Constants/Constant.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as http_parser;

class ApiRepository {
  Future<http.Response> RegisterOTPVerification(Object modal) async {
    String Url = BaseUrl + "verification";
    print("REQUEST---> $Url");
    print("REQUEST_DATA RegisterOTPVerification---> $modal");
    var body = await http.post(Uri.parse(Url), body: modal);
    print("Response--> $body");
    return body;
  }

  Future<http.Response> LoginOTPVerification(Object modal) async {
    String Url = BaseUrl + "verification";
    print("REQUEST---> $Url");
    print("REQUEST_DATA LoginOTPVerification---> $modal");
    var body = await http.post(Uri.parse(Url), body: modal);
    return body;
  }

  Future<http.Response> OTPVerification(Object modal) async {
    String Url = BaseUrl + "verification";
    print("REQUEST---> $Url");
    print("REQUEST_DATA LoginOTPVerification---> $modal");
    var body = await http.post(Uri.parse(Url), body: modal);
    return body;
  }

  Future Register(Map<String, dynamic> modal) async {
    String Url = BaseUrl + "register";
    var body = await http.post(Uri.parse(Url), body: modal);
    return body;
  }

  Future<http.Response> Login(Object modal) async {
    String Url = BaseUrl + "user/login";
    print("API_REQUEST-->$Url");
    print("API_REQUEST Login-->$modal");
    var body = await http.post(Uri.parse(Url), body: modal);
    print("API_REQUEST-->$body");
    return body;
  }

  Future<RecordingModalClass> RecordingUploader(
      String userId, String path) async {
    print("API_REQUEST-->$userId");
    String Url = BaseUrl + "query/store";
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Url),
    );
    request.fields["user_id"] = userId;
    Uint8List fileContent = await File(path).readAsBytes();

    request.files.add(http.MultipartFile.fromBytes('audio_file', fileContent,
        filename: path.split("/").last,
        contentType: http_parser.MediaType('audio_file', 'mp3')));

    // request.files.add(await http.MultipartFile.fromPath(
    //     "audio_file", File(path).path..toString(),
    //     contentType: http_parser.MediaType('audio', 'mp3')));
    // var body = await http.post(Uri.parse(Url), body: modal);
    print("This is Request: -> $request");
    var apiResponse = await request.send();
    print("This is response: -> ${apiResponse.statusCode}");
    // print(
    // "This is response: -> ${apiResponse.stream.bytesToString().toString()}");
    final responseString = await apiResponse.stream.bytesToString();
    Map<String, dynamic> response = json.decode(responseString);
    RecordingModalClass recordingModalClass =
        RecordingModalClass.fromJson(response);
    print("This is response: -> ${recordingModalClass.message}");

    return recordingModalClass;
  }

  Future<http.Response> AskFormUpload(Object modal) async {
    String Url = BaseUrl + "query/update/3";
    var body = await http.post(Uri.parse(Url), body: modal);
    print("asdsf $body");
    return body;
  }

  Future<http.Response> GetInquries(int id) async {
    String Url = BaseUrl + "user/query/list?user_id=$id";
    var body = await http.get(
      Uri.parse(Url),
    );
    return body;
  }

  Future<http.Response> GetResponse(int id, int queryId) async {
    String Url = BaseUrl + "response/list?query_id=$queryId&user_id=$id";
    print("REQUEST_URL-->" + Url);
    var body = await http.get(Uri.parse(Url));
    print("Response_BODY-->" + body.body.toString());

    return body;
  }

//https://viragtea.com/localsmart/public/api/response/details/4
  Future<http.Response> GetShopDetail(int userId) async {
    String Url = BaseUrl + "response/details/$userId";
    print("REQUEST_URL-->" + Url);
    var body = await http.get(
      Uri.parse(Url),
    );
    print("Response_BODY-->" + body.body.toString());
    return body;
  }

  Future<dynamic> ResendOtp(Object modal) async {
    String Url = BaseUrl + "resend";
    print("REQUEST---> $Url");
    var response = await http.post(Uri.parse(Url), body: modal);
    print("Response-->" + response.body.toString());
    print("Response-->${jsonDecode(response.body)}");
    return response.body;
  }
}
