import 'package:customer_app/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:customer_app/features/booking/presentation/bloc/booking_event.dart';
import 'package:customer_app/features/booking/presentation/bloc/booking_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NewBookingScreen extends StatefulWidget {
  const NewBookingScreen({super.key});

  @override
  State<NewBookingScreen> createState() => _NewBookingScreenState();
}

class _NewBookingScreenState extends State<NewBookingScreen> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  int _guestsCount = 2;
  int? _selectedTableId;
  final _specialRequestController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<BookingBloc>().add(LoadAvailableTablesRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Reservation')),
      body: BlocListener<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state is BookingSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Reservation successful!')),
            );
            Navigator.of(context).pop();
          } else if (state is BookingFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select Date & Time', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 30)),
                        );
                        if (picked != null) setState(() => _selectedDate = picked);
                      },
                      icon: const Icon(Icons.calendar_today),
                      label: Text(DateFormat('MMM dd, yyyy').format(_selectedDate)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: _selectedTime,
                        );
                        if (picked != null) setState(() => _selectedTime = picked);
                      },
                      icon: const Icon(Icons.access_time),
                      label: Text(_selectedTime.format(context)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text('Number of Guests', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  IconButton(
                    onPressed: _guestsCount > 1 ? () => setState(() => _guestsCount--) : null,
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  Text('$_guestsCount', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  IconButton(
                    onPressed: () => setState(() => _guestsCount++),
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text('Select Table', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              BlocBuilder<BookingBloc, BookingState>(
                builder: (context, state) {
                  if (state is BookingLoading && _selectedTableId == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TablesLoaded || (state is BookingLoading && _selectedTableId != null)) {
                    final tables = state is TablesLoaded ? state.tables : [];
                    if (tables.isEmpty && state is TablesLoaded) {
                      return const Text('No tables available at the moment.');
                    }
                    return Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: tables.map((table) {
                        final isSelected = _selectedTableId == table.id;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedTableId = table.id),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.orange : Colors.white,
                              border: Border.all(color: isSelected ? Colors.orange : Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.event_seat, color: isSelected ? Colors.white : Colors.grey),
                                Text(
                                  table.tableNumber,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${table.capacity} seats',
                                  style: TextStyle(
                                    color: isSelected ? Colors.white70 : Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 24),
              const Text('Special Requests', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: _specialRequestController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Any specific requirements?',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _selectedTableId == null
                    ? null
                    : () {
                        context.read<BookingBloc>().add(CreateBookingRequested(
                              tableId: _selectedTableId!,
                              bookingDate: DateFormat('yyyy-MM-dd').format(_selectedDate),
                              timeSlot: '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}:00',
                              guestsCount: _guestsCount,
                              specialRequest: _specialRequestController.text,
                            ));
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Confirm Reservation', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
