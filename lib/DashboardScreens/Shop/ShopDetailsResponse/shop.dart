import 'dart:convert';

import 'package:collection/collection.dart';

import 'category.dart';
import 'shop_image.dart';

class Shop {
  int? id;
  int? userId;
  String? shopName;
  String? ownerName;
  String? businessType;
  String? contactNumber;
  String? email;
  String? address;
  String? websiteUrl;
  String? gstNumber;
  String? personalKycDocName;
  String? personalKycDoc;
  String? personalKycDocNumber;
  String? businessKycDocName;
  String? businessKycDoc;
  String? businessKycDocNumber;
  List<ShopImage>? shopImages;
  int? stateId;
  int? cityId;
  dynamic pincode;
  dynamic address1;
  dynamic mapLocation;
  dynamic zipCode;
  int? status;
  int? verifiedStatus;
  dynamic driveLink;
  dynamic latitude;
  dynamic longitude;
  dynamic businessKycDocumentId;
  dynamic businessUploadedDocumentId;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  List<Category>? categories;
  String? category;
  dynamic vendor;

  Shop({
    this.id,
    this.userId,
    this.shopName,
    this.ownerName,
    this.businessType,
    this.contactNumber,
    this.email,
    this.address,
    this.websiteUrl,
    this.gstNumber,
    this.personalKycDocName,
    this.personalKycDoc,
    this.personalKycDocNumber,
    this.businessKycDocName,
    this.businessKycDoc,
    this.businessKycDocNumber,
    this.shopImages,
    this.stateId,
    this.cityId,
    this.pincode,
    this.address1,
    this.mapLocation,
    this.zipCode,
    this.status,
    this.verifiedStatus,
    this.driveLink,
    this.latitude,
    this.longitude,
    this.businessKycDocumentId,
    this.businessUploadedDocumentId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.categories,
    this.category,
    this.vendor,
  });

  @override
  String toString() {
    return 'Shop(id: $id, userId: $userId, shopName: $shopName, ownerName: $ownerName, businessType: $businessType, contactNumber: $contactNumber, email: $email, address: $address, websiteUrl: $websiteUrl, gstNumber: $gstNumber, personalKycDocName: $personalKycDocName, personalKycDoc: $personalKycDoc, personalKycDocNumber: $personalKycDocNumber, businessKycDocName: $businessKycDocName, businessKycDoc: $businessKycDoc, businessKycDocNumber: $businessKycDocNumber, shopImages: $shopImages, stateId: $stateId, cityId: $cityId, pincode: $pincode, address1: $address1, mapLocation: $mapLocation, zipCode: $zipCode, status: $status, verifiedStatus: $verifiedStatus, driveLink: $driveLink, latitude: $latitude, longitude: $longitude, businessKycDocumentId: $businessKycDocumentId, businessUploadedDocumentId: $businessUploadedDocumentId, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, categories: $categories, category: $category, vendor: $vendor)';
  }

  factory Shop.fromMap(Map<String, dynamic> data) => Shop(
        id: data['id'] as int?,
        userId: data['user_id'] as int?,
        shopName: data['shop_name'] as String?,
        ownerName: data['owner_name'] as String?,
        businessType: data['business_type'] as String?,
        contactNumber: data['contact_number'] as String?,
        email: data['email'] as String?,
        address: data['address'] as String?,
        websiteUrl: data['website_url'] as String?,
        gstNumber: data['gst_number'] as String?,
        personalKycDocName: data['personal_kyc_doc_name'] as String?,
        personalKycDoc: data['personal_kyc_doc'] as String?,
        personalKycDocNumber: data['personal_kyc_doc_number'] as String?,
        businessKycDocName: data['business_kyc_doc_name'] as String?,
        businessKycDoc: data['business_kyc_doc'] as String?,
        businessKycDocNumber: data['business_kyc_doc_number'] as String?,
        shopImages: (data['shop_images'] as List<dynamic>?)
            ?.map((e) => ShopImage.fromMap(e as Map<String, dynamic>))
            .toList(),
        stateId: data['state_id'] as int?,
        cityId: data['city_id'] as int?,
        pincode: data['pincode'] as dynamic,
        address1: data['address1'] as dynamic,
        mapLocation: data['map_location'] as dynamic,
        zipCode: data['zip_code'] as dynamic,
        status: data['status'] as int?,
        verifiedStatus: data['verified_status'] as int?,
        driveLink: data['drive_link'] as dynamic,
        latitude: data['latitude'] as dynamic,
        longitude: data['longitude'] as dynamic,
        businessKycDocumentId: data['business_kyc_document_id'] as dynamic,
        businessUploadedDocumentId:
            data['business_uploaded_document_id'] as dynamic,
        createdAt: data['created_at'] as String?,
        updatedAt: data['updated_at'] as String?,
        deletedAt: data['deleted_at'] as dynamic,
        categories: (data['categories'] as List<dynamic>?)
            ?.map((e) => Category.fromMap(e as Map<String, dynamic>))
            .toList(),
        category: data['category'] as String?,
        vendor: data['vendor'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'shop_name': shopName,
        'owner_name': ownerName,
        'business_type': businessType,
        'contact_number': contactNumber,
        'email': email,
        'address': address,
        'website_url': websiteUrl,
        'gst_number': gstNumber,
        'personal_kyc_doc_name': personalKycDocName,
        'personal_kyc_doc': personalKycDoc,
        'personal_kyc_doc_number': personalKycDocNumber,
        'business_kyc_doc_name': businessKycDocName,
        'business_kyc_doc': businessKycDoc,
        'business_kyc_doc_number': businessKycDocNumber,
        'shop_images': shopImages?.map((e) => e.toMap()).toList(),
        'state_id': stateId,
        'city_id': cityId,
        'pincode': pincode,
        'address1': address1,
        'map_location': mapLocation,
        'zip_code': zipCode,
        'status': status,
        'verified_status': verifiedStatus,
        'drive_link': driveLink,
        'latitude': latitude,
        'longitude': longitude,
        'business_kyc_document_id': businessKycDocumentId,
        'business_uploaded_document_id': businessUploadedDocumentId,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'deleted_at': deletedAt,
        'categories': categories?.map((e) => e.toMap()).toList(),
        'category': category,
        'vendor': vendor,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Shop].
  factory Shop.fromJson(String data) {
    return Shop.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Shop] to a JSON string.
  String toJson() => json.encode(toMap());

  Shop copyWith({
    int? id,
    int? userId,
    String? shopName,
    String? ownerName,
    String? businessType,
    String? contactNumber,
    String? email,
    String? address,
    String? websiteUrl,
    String? gstNumber,
    String? personalKycDocName,
    String? personalKycDoc,
    String? personalKycDocNumber,
    String? businessKycDocName,
    String? businessKycDoc,
    String? businessKycDocNumber,
    List<ShopImage>? shopImages,
    int? stateId,
    int? cityId,
    dynamic pincode,
    dynamic address1,
    dynamic mapLocation,
    dynamic zipCode,
    int? status,
    int? verifiedStatus,
    dynamic driveLink,
    dynamic latitude,
    dynamic longitude,
    dynamic businessKycDocumentId,
    dynamic businessUploadedDocumentId,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    List<Category>? categories,
    String? category,
    dynamic vendor,
  }) {
    return Shop(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      shopName: shopName ?? this.shopName,
      ownerName: ownerName ?? this.ownerName,
      businessType: businessType ?? this.businessType,
      contactNumber: contactNumber ?? this.contactNumber,
      email: email ?? this.email,
      address: address ?? this.address,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      gstNumber: gstNumber ?? this.gstNumber,
      personalKycDocName: personalKycDocName ?? this.personalKycDocName,
      personalKycDoc: personalKycDoc ?? this.personalKycDoc,
      personalKycDocNumber: personalKycDocNumber ?? this.personalKycDocNumber,
      businessKycDocName: businessKycDocName ?? this.businessKycDocName,
      businessKycDoc: businessKycDoc ?? this.businessKycDoc,
      businessKycDocNumber: businessKycDocNumber ?? this.businessKycDocNumber,
      shopImages: shopImages ?? this.shopImages,
      stateId: stateId ?? this.stateId,
      cityId: cityId ?? this.cityId,
      pincode: pincode ?? this.pincode,
      address1: address1 ?? this.address1,
      mapLocation: mapLocation ?? this.mapLocation,
      zipCode: zipCode ?? this.zipCode,
      status: status ?? this.status,
      verifiedStatus: verifiedStatus ?? this.verifiedStatus,
      driveLink: driveLink ?? this.driveLink,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      businessKycDocumentId:
          businessKycDocumentId ?? this.businessKycDocumentId,
      businessUploadedDocumentId:
          businessUploadedDocumentId ?? this.businessUploadedDocumentId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      categories: categories ?? this.categories,
      category: category ?? this.category,
      vendor: vendor ?? this.vendor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Shop) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      shopName.hashCode ^
      ownerName.hashCode ^
      businessType.hashCode ^
      contactNumber.hashCode ^
      email.hashCode ^
      address.hashCode ^
      websiteUrl.hashCode ^
      gstNumber.hashCode ^
      personalKycDocName.hashCode ^
      personalKycDoc.hashCode ^
      personalKycDocNumber.hashCode ^
      businessKycDocName.hashCode ^
      businessKycDoc.hashCode ^
      businessKycDocNumber.hashCode ^
      shopImages.hashCode ^
      stateId.hashCode ^
      cityId.hashCode ^
      pincode.hashCode ^
      address1.hashCode ^
      mapLocation.hashCode ^
      zipCode.hashCode ^
      status.hashCode ^
      verifiedStatus.hashCode ^
      driveLink.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      businessKycDocumentId.hashCode ^
      businessUploadedDocumentId.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      deletedAt.hashCode ^
      categories.hashCode ^
      category.hashCode ^
      vendor.hashCode;
}
