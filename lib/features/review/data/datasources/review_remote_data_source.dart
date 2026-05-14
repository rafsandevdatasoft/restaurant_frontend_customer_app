import 'package:customer_app/core/config/api_config.dart';
import 'package:customer_app/features/review/data/models/review_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'review_remote_data_source.g.dart';

@RestApi(baseUrl: ApiConfig.baseUrl)
abstract class ReviewRemoteDataSource {
  factory ReviewRemoteDataSource(Dio dio, {String baseUrl}) = _ReviewRemoteDataSource;

  @POST("/reviews")
  Future<ReviewModel> submitReview(@Body() Map<String, dynamic> body);

  @GET("/reviews/product/{productId}")
  Future<List<ReviewModel>> getProductReviews(@Path("productId") int productId);
}
