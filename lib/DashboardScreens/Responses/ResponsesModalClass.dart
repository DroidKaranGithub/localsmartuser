import 'dart:developer';

class ResponseModalClass {
  List<ResponseData>? data;
  bool? status;

  ResponseModalClass({this.data, this.status});

  ResponseModalClass.fromJson(Map<String, dynamic> json) {
    //log("Datais $json");
    if (json['data'] != null) {
      data = <ResponseData>[];
      json['data'].forEach((v) {
        data!.add(new ResponseData.fromJson(v));
      });

      // data!.forEach((element) {
      //   print(element.title);
      // });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class ResponseData {
  String? id;
  String? queryId;
  String? shopId;
  String? title;
  String? price;
  String? status;
  String? statusByCustomer;
  String? response;
//  List<String>? productImage; //response_pdf
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  ResponseShop? shop;

  ResponseData(
      {this.id,
      this.queryId,
      this.shopId,
      this.title,
      this.price,
      this.status,
      this.statusByCustomer,
      this.response,
      //this.productImage,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.shop});

  ResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    queryId = json['query_id'].toString();
    shopId = json['shop_id'].toString();
    title = json['title'].toString();
    price = json['price'].toString();
    status = json['status'].toString();
    statusByCustomer = json['status_by_customer'].toString();
    response = json['response'].toString();
    //productImage!.add(json['product_image'].toString());
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    deletedAt = json['deleted_at'].toString();
    shop =
        json['shop'] != null ? new ResponseShop.fromJson(json['shop']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['query_id'] = this.queryId;
    data['shop_id'] = this.shopId;
    data['title'] = this.title;
    data['price'] = this.price;
    data['status'] = this.status;
    data['status_by_customer'] = this.statusByCustomer;
    data['response'] = this.response;
    //  data['product_image'] = this.productImage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.shop != null) {
      data['shop'] = this.shop!.toJson();
    }
    return data;
  }
}

class ResponseShop {
  String? id;
  String? userId;
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
  List? shopImages;
  String? stateId;
  String? cityId;
  String? pincode;
  String? address1;
  String? mapLocation;
  String? zipCode;
  String? status;
  String? verifiedStatus;
  String? driveLink;
  String? latitude;
  String? longitude;
  String? businessKycDocumentId;
  String? businessUploadedDocumentId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? category;
  ResponseShop(
      {this.id,
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
      this.category});

  ResponseShop.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    userId = json['user_id'].toString();
    shopName = json['shop_name'].toString();
    ownerName = json['owner_name'].toString();
    businessType = json['business_type'].toString();
    contactNumber = json['contact_number'].toString();
    email = json['email'].toString();
    address = json['address'].toString();
    websiteUrl = json['website_url'].toString();
    gstNumber = json['gst_number'].toString();
    personalKycDocName = json['personal_kyc_doc_name'].toString();
    personalKycDoc = json['personal_kyc_doc'].toString();
    personalKycDocNumber = json['personal_kyc_doc_number'].toString();
    businessKycDocName = json['business_kyc_doc_name'].toString();
    businessKycDoc = json['business_kyc_doc'].toString();
    businessKycDocNumber = json['business_kyc_doc_number'].toString();
    if (json['shop_images'] != null) {
      json['shop_images'].forEach((v) {
        shopImages?.add(v);
        print("shop image url $v");
      });
    }
    stateId = json['state_id'].toString();
    cityId = json['city_id'].toString();
    pincode = json['pincode'].toString();
    address1 = json['address1'].toString();
    mapLocation = json['map_location'].toString();
    zipCode = json['zip_code'].toString();
    status = json['status'].toString();
    verifiedStatus = json['verified_status'].toString();
    driveLink = json['drive_link'].toString();
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
    businessKycDocumentId = json['business_kyc_document_id'].toString();
    businessUploadedDocumentId =
        json['business_uploaded_document_id'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    deletedAt = json['deleted_at'].toString();
    category = json['category'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['shop_name'] = this.shopName;
    data['owner_name'] = this.ownerName;
    data['business_type'] = this.businessType;
    data['contact_number'] = this.contactNumber;
    data['email'] = this.email;
    data['address'] = this.address;
    data['website_url'] = this.websiteUrl;
    data['gst_number'] = this.gstNumber;
    data['personal_kyc_doc_name'] = this.personalKycDocName;
    data['personal_kyc_doc'] = this.personalKycDoc;
    data['personal_kyc_doc_number'] = this.personalKycDocNumber;
    data['business_kyc_doc_name'] = this.businessKycDocName;
    data['business_kyc_doc'] = this.businessKycDoc;
    data['business_kyc_doc_number'] = this.businessKycDocNumber;
    if (this.shopImages != null) {
      data['shop_images'] = this.shopImages?.map((v) => v.toJson()).toList();
    }
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['pincode'] = this.pincode;
    data['address1'] = this.address1;
    data['map_location'] = this.mapLocation;
    data['zip_code'] = this.zipCode;
    data['status'] = this.status;
    data['verified_status'] = this.verifiedStatus;
    data['drive_link'] = this.driveLink;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['business_kyc_document_id'] = this.businessKycDocumentId;
    data['business_uploaded_document_id'] = this.businessUploadedDocumentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['category'] = this.category;
    return data;
  }
}
