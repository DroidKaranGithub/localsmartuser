import 'package:dio/dio.dart';

class AskFormModalClass {
  var message;
  var Status;

  String? UserId;
  String? ImageTitle;
  String? Url;
  String? Description;

  AskFormModalClass({this.UserId, this.ImageTitle, this.Url, this.Description});

  AskFormModalClass.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    Status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = UserId;
    data['title'] = ImageTitle;
    data['product_url'] = Url;
    data['description'] = Description;
    return data;
  }
}
