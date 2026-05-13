import 'package:customer_app/core/error/failures.dart';
import 'package:customer_app/features/menu/data/models/category_model.dart';
import 'package:customer_app/features/menu/data/models/product_model.dart';
import 'package:dartz/dartz.dart';

abstract class MenuRepository {
  Future<Either<Failure, List<CategoryModel>>> getCategories();
  Future<Either<Failure, List<ProductModel>>> getProducts({int? categoryId, String? search});
  Future<Either<Failure, ProductModel>> getProductById(int id);
}
