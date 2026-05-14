import 'package:customer_app/core/error/failures.dart';
import 'package:customer_app/features/booking/data/datasources/booking_remote_data_source.dart';
import 'package:customer_app/features/booking/data/models/booking_model.dart';
import 'package:customer_app/features/booking/data/models/table_model.dart';
import 'package:customer_app/features/booking/domain/repositories/booking_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;

  BookingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, BookingModel>> createBooking({
    required int tableId,
    required String bookingDate,
    required String timeSlot,
    required int guestsCount,
    String? specialRequest,
  }) async {
    try {
      final booking = await remoteDataSource.createBooking({
        "tableId": tableId,
        "bookingDate": bookingDate,
        "timeSlot": timeSlot,
        "guestsCount": guestsCount,
        "specialRequest": specialRequest,
      });
      return Right(booking);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? "Server Error"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookingModel>>> getMyBookings() async {
    try {
      final bookings = await remoteDataSource.getMyBookings();
      return Right(bookings);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? "Server Error"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TableModel>>> getAvailableTables() async {
    try {
      final tables = await remoteDataSource.getAvailableTables();
      return Right(tables);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? "Server Error"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
