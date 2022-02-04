import 'dart:convert';

import 'package:collection/collection.dart';

class ShopImage {
  String? image;

  ShopImage({this.image});

  @override
  String toString() => 'ShopImage(image: $image)';

  factory ShopImage.fromMap(Map<String, dynamic> data) => ShopImage(
        image: data['image'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'image': image,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ShopImage].
  factory ShopImage.fromJson(String data) {
    return ShopImage.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ShopImage] to a JSON string.
  String toJson() => json.encode(toMap());

  ShopImage copyWith({
    String? image,
  }) {
    return ShopImage(
      image: image ?? this.image,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ShopImage) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => image.hashCode;
}
