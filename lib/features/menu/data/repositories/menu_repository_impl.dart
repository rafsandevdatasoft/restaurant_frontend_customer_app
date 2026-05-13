import 'package:customer_app/core/error/failures.dart';
import 'package:customer_app/features/menu/data/datasources/menu_remote_data_source.dart';
import 'package:customer_app/features/menu/data/models/category_model.dart';
import 'package:customer_app/features/menu/data/models/product_model.dart';
import 'package:customer_app/features/menu/domain/repositories/menu_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class MenuRepositoryImpl implements MenuRepository {
  final MenuRemoteDataSource remoteDataSource;

  MenuRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Right(categories);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? "Server Error"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts({int? categoryId, String? search}) async {
    try {
      final Map<String, dynamic> queries = {};
      if (categoryId != null) queries['categoryId'] = categoryId;
      if (search != null) queries['search'] = search;
      
      final products = await remoteDataSource.getProducts(queries);
      return Right(products);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? "Server Error"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> getProductById(int id) async {
    try {
      final product = await remoteDataSource.getProductById(id);
      return Right(product);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? "Server Error"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
