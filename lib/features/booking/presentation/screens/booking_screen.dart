import 'package:customer_app/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:customer_app/features/booking/presentation/bloc/booking_event.dart';
import 'package:customer_app/features/booking/presentation/bloc/booking_state.dart';
import 'package:customer_app/features/booking/presentation/screens/new_booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BookingBloc>().add(LoadMyBookingsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        centerTitle: true,
      ),
      body: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          if (state is BookingLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookingsLoaded) {
            final bookings = state.bookings;
            if (bookings.isEmpty) {
              return _buildEmptyState();
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange.shade50,
                      child: const Icon(Icons.event_seat, color: Colors.orange),
                    ),
                    title: Text('Table ${booking.tableNumber}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${booking.bookingDate} at ${booking.timeSlot}'),
                        Text('${booking.guestsCount} guests'),
                      ],
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(booking.status!).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        booking.status!,
                        style: TextStyle(
                          color: _getStatusColor(booking.status!),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is BookingFailure) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const NewBookingScreen()),
          ).then((_) => context.read<BookingBloc>().add(LoadMyBookingsRequested()));
        },
        label: const Text('Book a Table'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_seat_outlined, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          const Text('No bookings found', style: TextStyle(fontSize: 18, color: Colors.grey)),
          const SizedBox(height: 8),
          const Text('Reserve your favorite table now!', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'PENDING':
        return Colors.orange;
      case 'CONFIRMED':
        return Colors.green;
      case 'CANCELLED':
        return Colors.red;
      case 'COMPLETED':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
