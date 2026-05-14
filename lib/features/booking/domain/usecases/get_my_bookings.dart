import 'package:customer_app/core/error/failures.dart';
import 'package:customer_app/core/usecases/usecase.dart';
import 'package:customer_app/features/booking/data/models/booking_model.dart';
import 'package:customer_app/features/booking/domain/repositories/booking_repository.dart';
import 'package:dartz/dartz.dart';

class GetMyBookings implements UseCase<List<BookingModel>, NoParams> {
  final BookingRepository repository;

  GetMyBookings(this.repository);

  @override
  Future<Either<Failure, List<BookingModel>>> call(NoParams params) async {
    return await repository.getMyBookings();
  }
}
