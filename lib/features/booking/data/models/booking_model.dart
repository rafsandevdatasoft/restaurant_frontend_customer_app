import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_model.g.dart';

@JsonSerializable()
class BookingModel extends Equatable {
  final int? id;
  final String? tableNumber;
  final String bookingDate;
  final String timeSlot;
  final int guestsCount;
  final String? status;
  final String? specialRequest;

  const BookingModel({
    this.id,
    this.tableNumber,
    required this.bookingDate,
    required this.timeSlot,
    required this.guestsCount,
    this.status,
    this.specialRequest,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => _$BookingModelFromJson(json);
  Map<String, dynamic> toJson() => _$BookingModelToJson(this);

  @override
  List<Object?> get props => [id, tableNumber, bookingDate, timeSlot, guestsCount, status, specialRequest];
}
