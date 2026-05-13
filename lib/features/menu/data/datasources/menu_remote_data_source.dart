import 'package:customer_app/core/config/api_config.dart';
import 'package:customer_app/features/menu/data/models/category_model.dart';
import 'package:customer_app/features/menu/data/models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'menu_remote_data_source.g.dart';

@RestApi(baseUrl: ApiConfig.baseUrl)
abstract class MenuRemoteDataSource {
  factory MenuRemoteDataSource(Dio dio, {String baseUrl}) = _MenuRemoteDataSource;

  @GET(ApiConfig.categoriesEndpoint)
  Future<List<CategoryModel>> getCategories();

  @GET(ApiConfig.productsEndpoint)
  Future<List<ProductModel>> getProducts(@Queries() Map<String, dynamic> queries);

  @GET("${ApiConfig.productsEndpoint}/{id}")
  Future<ProductModel> getProductById(@Path("id") int id);
}
