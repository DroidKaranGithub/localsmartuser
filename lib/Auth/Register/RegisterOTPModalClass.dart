class RegisterOTPModalClass {
  String? name;
  String? phone;
  String? Otp;
  String? Msg;
  RegisterOTPModalClass({this.name, this.phone, this.Otp});

  RegisterOTPModalClass.fromJson(Map<String, dynamic> json) {
    Otp = json['otp'].toString();
    Msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['otp'] = this.Otp.toString();
    data['type'] = "1";
    data['role_id'] = "3";
    return data;
  }
}
