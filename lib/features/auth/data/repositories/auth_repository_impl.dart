import 'package:customer_app/core/error/failures.dart';
import 'package:customer_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:customer_app/features/auth/domain/entities/user.dart';
import 'package:customer_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> login(String username, String password) async {
    try {
      final userModel = await remoteDataSource.login({
        "username": username,
        "password": password,
      });
      return Right(userModel);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? "Server Error"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signup(String username, String email, String password) async {
    try {
      await remoteDataSource.signup({
        "username": username,
        "email": email,
        "password": password,
      });
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? "Server Error"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
