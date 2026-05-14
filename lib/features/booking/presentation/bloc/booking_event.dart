import 'package:equatable/equatable.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class LoadAvailableTablesRequested extends BookingEvent {}

class CreateBookingRequested extends BookingEvent {
  final int tableId;
  final String bookingDate;
  final String timeSlot;
  final int guestsCount;
  final String? specialRequest;

  const CreateBookingRequested({
    required this.tableId,
    required this.bookingDate,
    required this.timeSlot,
    required this.guestsCount,
    this.specialRequest,
  });

  @override
  List<Object?> get props => [tableId, bookingDate, timeSlot, guestsCount, specialRequest];
}

class LoadMyBookingsRequested extends BookingEvent {}
