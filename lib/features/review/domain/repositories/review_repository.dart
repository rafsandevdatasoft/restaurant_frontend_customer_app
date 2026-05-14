import 'package:customer_app/core/error/failures.dart';
import 'package:customer_app/features/review/data/models/review_model.dart';
import 'package:dartz/dartz.dart';

abstract class ReviewRepository {
  Future<Either<Failure, ReviewModel>> submitReview({
    required int productId,
    required int rating,
    required String comment,
  });

  Future<Either<Failure, List<ReviewModel>>> getProductReviews(int productId);
}
