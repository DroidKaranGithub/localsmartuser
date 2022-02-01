import 'package:collection/collection.dart';

class Data {
  int? id;
  String? roleId;
  dynamic role;
  String? name;
  String? email;
  String? phone;
  dynamic address;
  dynamic address2;
  dynamic cityId;
  dynamic stateId;
  dynamic driveLink;
  dynamic profileImage;
  String? currentLocation;
  dynamic emailVerifiedAt;
  int? verifiyStatus;
  String? otpVerified;
  String? otp;
  int? status;
  dynamic profile;
  int? walletBalance;
  dynamic deviceToken;
  dynamic createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Data({
    this.id,
    this.roleId,
    this.role,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.address2,
    this.cityId,
    this.stateId,
    this.driveLink,
    this.profileImage,
    this.currentLocation,
    this.emailVerifiedAt,
    this.verifiyStatus,
    this.otpVerified,
    this.otp,
    this.status,
    this.profile,
    this.walletBalance,
    this.deviceToken,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        roleId: json['role_id'] as String?,
        role: json['role'] as dynamic,
        name: json['name'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        address: json['address'] as dynamic,
        address2: json['address2'] as dynamic,
        cityId: json['city_id'] as dynamic,
        stateId: json['state_id'] as dynamic,
        driveLink: json['drive_link'] as dynamic,
        profileImage: json['profile_image'] as dynamic,
        currentLocation: json['current_location'] as String?,
        emailVerifiedAt: json['email_verified_at'] as dynamic,
        verifiyStatus: json['verifiy_status'] as int?,
        otpVerified: json['otp_verified'] as String?,
        otp: json['otp'] as String?,
        status: json['status'] as int?,
        profile: json['profile'] as dynamic,
        walletBalance: json['wallet_balance'] as int?,
        deviceToken: json['device_token'] as dynamic,
        createdAt: json['created_at'] as dynamic,
        updatedAt: json['updated_at'] as String?,
        deletedAt: json['deleted_at'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'role_id': roleId,
        'role': role,
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'address2': address2,
        'city_id': cityId,
        'state_id': stateId,
        'drive_link': driveLink,
        'profile_image': profileImage,
        'current_location': currentLocation,
        'email_verified_at': emailVerifiedAt,
        'verifiy_status': verifiyStatus,
        'otp_verified': otpVerified,
        'otp': otp,
        'status': status,
        'profile': profile,
        'wallet_balance': walletBalance,
        'device_token': deviceToken,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'deleted_at': deletedAt,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      roleId.hashCode ^
      role.hashCode ^
      name.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      address.hashCode ^
      address2.hashCode ^
      cityId.hashCode ^
      stateId.hashCode ^
      driveLink.hashCode ^
      profileImage.hashCode ^
      currentLocation.hashCode ^
      emailVerifiedAt.hashCode ^
      verifiyStatus.hashCode ^
      otpVerified.hashCode ^
      otp.hashCode ^
      status.hashCode ^
      profile.hashCode ^
      walletBalance.hashCode ^
      deviceToken.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      deletedAt.hashCode;
}
