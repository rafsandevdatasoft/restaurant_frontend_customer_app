import 'package:bloc/bloc.dart';
import 'package:customer_app/core/usecases/usecase.dart';
import 'package:customer_app/features/booking/domain/usecases/create_booking.dart';
import 'package:customer_app/features/booking/domain/usecases/get_available_tables.dart';
import 'package:customer_app/features/booking/domain/usecases/get_my_bookings.dart';
import 'booking_event.dart';
import 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final CreateBooking createBooking;
  final GetMyBookings getMyBookings;
  final GetAvailableTables getAvailableTables;

  BookingBloc({
    required this.createBooking,
    required this.getMyBookings,
    required this.getAvailableTables,
  }) : super(BookingInitial()) {
    on<LoadAvailableTablesRequested>((event, emit) async {
      emit(BookingLoading());
      final result = await getAvailableTables(NoParams());
      result.fold(
        (failure) => emit(BookingFailure(failure.message)),
        (tables) => emit(TablesLoaded(tables)),
      );
    });

    on<CreateBookingRequested>((event, emit) async {
      emit(BookingLoading());
      final result = await createBooking(BookingParams(
        tableId: event.tableId,
        bookingDate: event.bookingDate,
        timeSlot: event.timeSlot,
        guestsCount: event.guestsCount,
        specialRequest: event.specialRequest,
      ));
      result.fold(
        (failure) => emit(BookingFailure(failure.message)),
        (booking) => emit(BookingSuccess(booking)),
      );
    });

    on<LoadMyBookingsRequested>((event, emit) async {
      emit(BookingLoading());
      final result = await getMyBookings(NoParams());
      result.fold(
        (failure) => emit(BookingFailure(failure.message)),
        (bookings) => emit(BookingsLoaded(bookings)),
      );
    });
  }
}
