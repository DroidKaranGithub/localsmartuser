// ignore_for_file: non_constant_identifier_names

class LoginOTPModalClass {
  String? phone;
  String? otp;
  bool? Status;
  String? Msg;
  LoginOTPModalClass({this.phone, this.otp});

  LoginOTPModalClass.fromJson(Map<String, dynamic> json) {
    Status = json['status'];
    Msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = phone;
    data['type'] = "2";
    data['otp'] = otp;
    data['role_id'] = "3";
    return data;
  }
}
