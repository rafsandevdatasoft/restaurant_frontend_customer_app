import 'package:customer_app/core/error/failures.dart';
import 'package:customer_app/core/usecases/usecase.dart';
import 'package:customer_app/features/booking/data/models/table_model.dart';
import 'package:customer_app/features/booking/domain/repositories/booking_repository.dart';
import 'package:dartz/dartz.dart';

class GetAvailableTables implements UseCase<List<TableModel>, NoParams> {
  final BookingRepository repository;

  GetAvailableTables(this.repository);

  @override
  Future<Either<Failure, List<TableModel>>> call(NoParams params) async {
    return await repository.getAvailableTables();
  }
}
