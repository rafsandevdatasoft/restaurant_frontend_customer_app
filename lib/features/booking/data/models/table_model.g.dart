// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableModel _$TableModelFromJson(Map<String, dynamic> json) => TableModel(
      id: (json['id'] as num).toInt(),
      tableNumber: json['tableNumber'] as String,
      capacity: (json['capacity'] as num).toInt(),
      location: json['location'] as String?,
      status: json['status'] as String,
    );

Map<String, dynamic> _$TableModelToJson(TableModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tableNumber': instance.tableNumber,
      'capacity': instance.capacity,
      'location': instance.location,
      'status': instance.status,
    };
