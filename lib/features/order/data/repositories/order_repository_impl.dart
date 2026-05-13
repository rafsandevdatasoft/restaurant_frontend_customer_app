import 'package:customer_app/core/error/failures.dart';
import 'package:customer_app/features/order/data/datasources/order_remote_data_source.dart';
import 'package:customer_app/features/order/data/models/order_model.dart';
import 'package:customer_app/features/order/domain/repositories/order_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, OrderModel>> placeOrder({
    required List<Map<String, dynamic>> items,
    required String orderType,
    int? addressId,
    String? specialInstructions,
  }) async {
    try {
      final order = await remoteDataSource.placeOrder({
        "items": items,
        "orderType": orderType,
        "addressId": addressId,
        "specialInstructions": specialInstructions,
      });
      return Right(order);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? "Server Error"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getMyOrders() async {
    try {
      final orders = await remoteDataSource.getMyOrders();
      return Right(orders);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? "Server Error"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
