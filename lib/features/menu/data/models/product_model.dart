import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final int id;
  final int categoryId;
  final String name;
  final String? description;
  final double price;
  final double? discountPrice;
  final bool isAvailable;
  final bool isPopular;
  final bool isFeatured;
  final List<String>? imageUrls;

  ProductModel({
    required this.id,
    required this.categoryId,
    required this.name,
    this.description,
    required this.price,
    this.discountPrice,
    required this.isAvailable,
    required this.isPopular,
    required this.isFeatured,
    this.imageUrls,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
