import 'package:equatable/equatable.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object?> get props => [];
}

class LoadProductReviewsRequested extends ReviewEvent {
  final int productId;
  const LoadProductReviewsRequested(this.productId);

  @override
  List<Object?> get props => [productId];
}

class SubmitReviewRequested extends ReviewEvent {
  final int productId;
  final int rating;
  final String comment;

  const SubmitReviewRequested({
    required this.productId,
    required this.rating,
    required this.comment,
  });

  @override
  List<Object?> get props => [productId, rating, comment];
}
