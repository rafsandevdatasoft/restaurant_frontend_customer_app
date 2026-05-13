import 'package:customer_app/core/error/failures.dart';
import 'package:customer_app/features/order/data/models/order_model.dart';
import 'package:dartz/dartz.dart';

abstract class OrderRepository {
  Future<Either<Failure, OrderModel>> placeOrder({
    required List<Map<String, dynamic>> items,
    required String orderType,
    int? addressId,
    String? specialInstructions,
  });
  
  Future<Either<Failure, List<OrderModel>>> getMyOrders();
}
