// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) => BookingModel(
      id: (json['id'] as num?)?.toInt(),
      tableNumber: json['tableNumber'] as String?,
      bookingDate: json['bookingDate'] as String,
      timeSlot: json['timeSlot'] as String,
      guestsCount: (json['guestsCount'] as num).toInt(),
      status: json['status'] as String?,
      specialRequest: json['specialRequest'] as String?,
    );

Map<String, dynamic> _$BookingModelToJson(BookingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tableNumber': instance.tableNumber,
      'bookingDate': instance.bookingDate,
      'timeSlot': instance.timeSlot,
      'guestsCount': instance.guestsCount,
      'status': instance.status,
      'specialRequest': instance.specialRequest,
    };
