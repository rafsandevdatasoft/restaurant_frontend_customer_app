import 'package:customer_app/core/config/api_config.dart';
import 'package:customer_app/features/order/data/models/order_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'order_remote_data_source.g.dart';

@RestApi(baseUrl: ApiConfig.baseUrl)
abstract class OrderRemoteDataSource {
  factory OrderRemoteDataSource(Dio dio, {String baseUrl}) = _OrderRemoteDataSource;

  @POST("/orders")
  Future<OrderModel> placeOrder(@Body() Map<String, dynamic> body);

  @GET("/orders/my")
  Future<List<OrderModel>> getMyOrders();
}
