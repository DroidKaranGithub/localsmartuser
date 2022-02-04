import 'dart:convert';

import 'package:collection/collection.dart';

import 'response.dart';
import 'shop.dart';

class ShopDetailsResponse {
  Response? response;
  Shop? shop;
  bool? status;

  ShopDetailsResponse({this.response, this.shop, this.status});

  @override
  String toString() {
    return 'ShopDetailsResponse(response: $response, shop: $shop, status: $status)';
  }

  factory ShopDetailsResponse.fromMap(Map<String, dynamic> data) {
    return ShopDetailsResponse(
      response: data['response'] == null
          ? null
          : Response.fromMap(data['response'] as Map<String, dynamic>),
      shop: data['shop'] == null
          ? null
          : Shop.fromMap(data['shop'] as Map<String, dynamic>),
      status: data['status'] as bool?,
    );
  }

  Map<String, dynamic> toMap() => {
        'response': response?.toMap(),
        'shop': shop?.toMap(),
        'status': status,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ShopDetailsResponse].
  factory ShopDetailsResponse.fromJson(String data) {
    return ShopDetailsResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ShopDetailsResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  ShopDetailsResponse copyWith({
    Response? response,
    Shop? shop,
    bool? status,
  }) {
    return ShopDetailsResponse(
      response: response ?? this.response,
      shop: shop ?? this.shop,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ShopDetailsResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => response.hashCode ^ shop.hashCode ^ status.hashCode;
}
