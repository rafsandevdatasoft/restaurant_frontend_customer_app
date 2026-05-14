import 'package:customer_app/features/booking/data/models/booking_model.dart';
import 'package:customer_app/features/booking/data/models/table_model.dart';
import 'package:equatable/equatable.dart';

abstract class BookingState extends Equatable {
  const BookingState();
  
  @override
  List<Object?> get props => [];
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class TablesLoaded extends BookingState {
  final List<TableModel> tables;
  const TablesLoaded(this.tables);

  @override
  List<Object?> get props => [tables];
}

class BookingSuccess extends BookingState {
  final BookingModel booking;
  const BookingSuccess(this.booking);

  @override
  List<Object?> get props => [booking];
}

class BookingsLoaded extends BookingState {
  final List<BookingModel> bookings;
  const BookingsLoaded(this.bookings);

  @override
  List<Object?> get props => [bookings];
}

class BookingFailure extends BookingState {
  final String message;
  const BookingFailure(this.message);

  @override
  List<Object?> get props => [message];
}
