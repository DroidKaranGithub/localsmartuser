class ResendOtp {
  String? msg;
  int? code;

  ResendOtp({this.msg, this.code});

  ResendOtp.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['code'] = this.code;

    return data;
  }
}
