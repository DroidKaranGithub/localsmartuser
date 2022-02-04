import 'dart:convert';

import 'package:collection/collection.dart';

class Category {
  int? id;
  String? name;
  int? status;
  int? isParent;
  dynamic parentId;
  int? bidingChargePrice;
  dynamic hotdealsPrice;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Category({
    this.id,
    this.name,
    this.status,
    this.isParent,
    this.parentId,
    this.bidingChargePrice,
    this.hotdealsPrice,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  @override
  String toString() {
    return 'Category(id: $id, name: $name, status: $status, isParent: $isParent, parentId: $parentId, bidingChargePrice: $bidingChargePrice, hotdealsPrice: $hotdealsPrice, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  factory Category.fromMap(Map<String, dynamic> data) => Category(
        id: data['id'] as int?,
        name: data['name'] as String?,
        status: data['status'] as int?,
        isParent: data['is_parent'] as int?,
        parentId: data['parent_id'] as dynamic,
        bidingChargePrice: data['biding_charge_price'] as int?,
        hotdealsPrice: data['hotdeals_price'] as dynamic,
        createdAt: data['created_at'] as String?,
        updatedAt: data['updated_at'] as String?,
        deletedAt: data['deleted_at'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'status': status,
        'is_parent': isParent,
        'parent_id': parentId,
        'biding_charge_price': bidingChargePrice,
        'hotdeals_price': hotdealsPrice,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'deleted_at': deletedAt,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Category].
  factory Category.fromJson(String data) {
    return Category.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Category] to a JSON string.
  String toJson() => json.encode(toMap());

  Category copyWith({
    int? id,
    String? name,
    int? status,
    int? isParent,
    dynamic parentId,
    int? bidingChargePrice,
    dynamic hotdealsPrice,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      isParent: isParent ?? this.isParent,
      parentId: parentId ?? this.parentId,
      bidingChargePrice: bidingChargePrice ?? this.bidingChargePrice,
      hotdealsPrice: hotdealsPrice ?? this.hotdealsPrice,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Category) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      status.hashCode ^
      isParent.hashCode ^
      parentId.hashCode ^
      bidingChargePrice.hashCode ^
      hotdealsPrice.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      deletedAt.hashCode;
}
