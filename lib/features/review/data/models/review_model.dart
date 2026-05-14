import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel extends Equatable {
  final int? id;
  final String? customerName;
  final int productId;
  final String? productName;
  final int rating;
  final String comment;
  final String? createdAt;

  const ReviewModel({
    this.id,
    this.customerName,
    required this.productId,
    this.productName,
    required this.rating,
    required this.comment,
    this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => _$ReviewModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);

  @override
  List<Object?> get props => [id, customerName, productId, productName, rating, comment, createdAt];
}
