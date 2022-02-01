class RecordingModalClass {
  String? Audio;
  String? UserId;
  var message;
  var status;
  String? userId;
  String? queryId;

  RecordingModalClass({this.UserId, this.Audio});

  RecordingModalClass.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    userId = json['data']['user_id'].toString();
    queryId = json['data']['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.UserId;
    data['audio_file'] = this.Audio;
    print("asdfrew0: $data");
    return data;
  }
}
