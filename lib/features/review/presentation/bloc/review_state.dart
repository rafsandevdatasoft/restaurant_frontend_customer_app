import 'package:customer_app/features/review/data/models/review_model.dart';
import 'package:equatable/equatable.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();
  
  @override
  List<Object?> get props => [];
}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewsLoaded extends ReviewState {
  final List<ReviewModel> reviews;
  const ReviewsLoaded(this.reviews);

  @override
  List<Object?> get props => [reviews];
}

class ReviewSubmitSuccess extends ReviewState {
  final ReviewModel review;
  const ReviewSubmitSuccess(this.review);

  @override
  List<Object?> get props => [review];
}

class ReviewFailure extends ReviewState {
  final String message;
  const ReviewFailure(this.message);

  @override
  List<Object?> get props => [message];
}
