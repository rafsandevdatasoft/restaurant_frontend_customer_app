// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: (json['id'] as num).toInt(),
      orderStatus: json['orderStatus'] as String,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      orderType: json['orderType'] as String,
      createdAt: json['createdAt'] as String,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderStatus': instance.orderStatus,
      'totalAmount': instance.totalAmount,
      'orderType': instance.orderType,
      'createdAt': instance.createdAt,
      'items': instance.items,
    };

OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) =>
    OrderItemModel(
      productName: json['productName'] as String,
      quantity: (json['quantity'] as num).toInt(),
      priceAtOrder: (json['priceAtOrder'] as num).toDouble(),
    );

Map<String, dynamic> _$OrderItemModelToJson(OrderItemModel instance) =>
    <String, dynamic>{
      'productName': instance.productName,
      'quantity': instance.quantity,
      'priceAtOrder': instance.priceAtOrder,
    };
