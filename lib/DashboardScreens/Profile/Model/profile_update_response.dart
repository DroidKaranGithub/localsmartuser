import 'package:collection/collection.dart';

import 'data.dart';

class ProfileUpdateResponse {
  String? message;
  Data? data;
  bool? status;

  ProfileUpdateResponse({this.message, this.data, this.status});

  factory ProfileUpdateResponse.fromJson(Map<String, dynamic> json) {
    return ProfileUpdateResponse(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'data': data?.toJson(),
        'status': status,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ProfileUpdateResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => message.hashCode ^ data.hashCode ^ status.hashCode;
}
