// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      id: (json['id'] as num?)?.toInt(),
      customerName: json['customerName'] as String?,
      productId: (json['productId'] as num).toInt(),
      productName: json['productName'] as String?,
      rating: (json['rating'] as num).toInt(),
      comment: json['comment'] as String,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerName': instance.customerName,
      'productId': instance.productId,
      'productName': instance.productName,
      'rating': instance.rating,
      'comment': instance.comment,
      'createdAt': instance.createdAt,
    };
