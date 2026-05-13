import 'package:customer_app/core/config/api_config.dart';
import 'package:customer_app/features/auth/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_remote_data_source.g.dart';

@RestApi(baseUrl: ApiConfig.baseUrl)
abstract class AuthRemoteDataSource {
  factory AuthRemoteDataSource(Dio dio, {String baseUrl}) = _AuthRemoteDataSource;

  @POST(ApiConfig.loginEndpoint)
  Future<UserModel> login(@Body() Map<String, dynamic> body);

  @POST(ApiConfig.signupEndpoint)
  Future<void> signup(@Body() Map<String, dynamic> body);
}
