import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  final int id;
  final String orderStatus;
  final double totalAmount;
  final String orderType;
  final String createdAt;
  final List<OrderItemModel>? items;

  OrderModel({
    required this.id,
    required this.orderStatus,
    required this.totalAmount,
    required this.orderType,
    required this.createdAt,
    this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

@JsonSerializable()
class OrderItemModel {
  final String productName;
  final int quantity;
  final double priceAtOrder;

  OrderItemModel({
    required this.productName,
    required this.quantity,
    required this.priceAtOrder,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => _$OrderItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);
}
