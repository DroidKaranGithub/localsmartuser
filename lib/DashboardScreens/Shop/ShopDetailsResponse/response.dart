import 'dart:convert';

import 'package:collection/collection.dart';

class Response {
  int? id;
  int? queryId;
  int? shopId;
  dynamic title;
  String? price;
  int? status;
  int? statusByCustomer;
  String? response;
  dynamic responsePdf;
  String? responseLink;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  List<dynamic>? responseImages;

  Response({
    this.id,
    this.queryId,
    this.shopId,
    this.title,
    this.price,
    this.status,
    this.statusByCustomer,
    this.response,
    this.responsePdf,
    this.responseLink,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.responseImages,
  });

  @override
  String toString() {
    return 'Response(id: $id, queryId: $queryId, shopId: $shopId, title: $title, price: $price, status: $status, statusByCustomer: $statusByCustomer, response: $response, responsePdf: $responsePdf, responseLink: $responseLink, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, responseImages: $responseImages)';
  }

  factory Response.fromMap(Map<String, dynamic> data) => Response(
        id: data['id'] as int?,
        queryId: data['query_id'] as int?,
        shopId: data['shop_id'] as int?,
        title: data['title'] as dynamic,
        price: data['price'] as String?,
        status: data['status'] as int?,
        statusByCustomer: data['status_by_customer'] as int?,
        response: data['response'] as String?,
        responsePdf: data['response_pdf'] as dynamic,
        responseLink: data['response_link'] as String?,
        createdAt: data['created_at'] as String?,
        updatedAt: data['updated_at'] as String?,
        deletedAt: data['deleted_at'] as dynamic,
        responseImages: data['response_images'] as List<dynamic>?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'query_id': queryId,
        'shop_id': shopId,
        'title': title,
        'price': price,
        'status': status,
        'status_by_customer': statusByCustomer,
        'response': response,
        'response_pdf': responsePdf,
        'response_link': responseLink,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'deleted_at': deletedAt,
        'response_images': responseImages,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Response].
  factory Response.fromJson(String data) {
    return Response.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Response] to a JSON string.
  String toJson() => json.encode(toMap());

  Response copyWith({
    int? id,
    int? queryId,
    int? shopId,
    dynamic title,
    String? price,
    int? status,
    int? statusByCustomer,
    String? response,
    dynamic responsePdf,
    String? responseLink,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    List<dynamic>? responseImages,
  }) {
    return Response(
      id: id ?? this.id,
      queryId: queryId ?? this.queryId,
      shopId: shopId ?? this.shopId,
      title: title ?? this.title,
      price: price ?? this.price,
      status: status ?? this.status,
      statusByCustomer: statusByCustomer ?? this.statusByCustomer,
      response: response ?? this.response,
      responsePdf: responsePdf ?? this.responsePdf,
      responseLink: responseLink ?? this.responseLink,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      responseImages: responseImages ?? this.responseImages,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Response) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      queryId.hashCode ^
      shopId.hashCode ^
      title.hashCode ^
      price.hashCode ^
      status.hashCode ^
      statusByCustomer.hashCode ^
      response.hashCode ^
      responsePdf.hashCode ^
      responseLink.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      deletedAt.hashCode ^
      responseImages.hashCode;
}
