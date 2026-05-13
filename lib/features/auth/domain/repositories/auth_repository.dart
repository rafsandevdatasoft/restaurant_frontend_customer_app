import 'package:customer_app/core/error/failures.dart';
import 'package:customer_app/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String username, String password);
  Future<Either<Failure, void>> signup(String username, String email, String password);
}
