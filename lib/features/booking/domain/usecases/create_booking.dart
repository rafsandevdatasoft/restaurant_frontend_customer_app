import 'package:customer_app/core/error/failures.dart';
import 'package:customer_app/core/usecases/usecase.dart';
import 'package:customer_app/features/booking/data/models/booking_model.dart';
import 'package:customer_app/features/booking/domain/repositories/booking_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CreateBooking implements UseCase<BookingModel, BookingParams> {
  final BookingRepository repository;

  CreateBooking(this.repository);

  @override
  Future<Either<Failure, BookingModel>> call(BookingParams params) async {
    return await repository.createBooking(
      tableId: params.tableId,
      bookingDate: params.bookingDate,
      timeSlot: params.timeSlot,
      guestsCount: params.guestsCount,
      specialRequest: params.specialRequest,
    );
  }
}

class BookingParams extends Equatable {
  final int tableId;
  final String bookingDate;
  final String timeSlot;
  final int guestsCount;
  final String? specialRequest;

  const BookingParams({
    required this.tableId,
    required this.bookingDate,
    required this.timeSlot,
    required this.guestsCount,
    this.specialRequest,
  });

  @override
  List<Object?> get props => [tableId, bookingDate, timeSlot, guestsCount, specialRequest];
}
