import 'package:customer_app/core/error/failures.dart';
import 'package:customer_app/features/review/data/datasources/review_remote_data_source.dart';
import 'package:customer_app/features/review/data/models/review_model.dart';
import 'package:customer_app/features/review/domain/repositories/review_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource remoteDataSource;

  ReviewRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ReviewModel>> submitReview({
    required int productId,
    required int rating,
    required String comment,
  }) async {
    try {
      final review = await remoteDataSource.submitReview({
        "productId": productId,
        "rating": rating,
        "comment": comment,
      });
      return Right(review);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? "Server Error"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ReviewModel>>> getProductReviews(int productId) async {
    try {
      final reviews = await remoteDataSource.getProductReviews(productId);
      return Right(reviews);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? "Server Error"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
