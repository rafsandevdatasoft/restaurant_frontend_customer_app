import 'package:customer_app/core/error/failures.dart';
import 'package:customer_app/features/booking/data/models/booking_model.dart';
import 'package:customer_app/features/booking/data/models/table_model.dart';
import 'package:dartz/dartz.dart';

abstract class BookingRepository {
  Future<Either<Failure, BookingModel>> createBooking({
    required int tableId,
    required String bookingDate,
    required String timeSlot,
    required int guestsCount,
    String? specialRequest,
  });

  Future<Either<Failure, List<BookingModel>>> getMyBookings();
  Future<Either<Failure, List<TableModel>>> getAvailableTables();
}
