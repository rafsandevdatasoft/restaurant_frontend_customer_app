import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'table_model.g.dart';

@JsonSerializable()
class TableModel extends Equatable {
  final int id;
  final String tableNumber;
  final int capacity;
  final String? location;
  final String status;

  const TableModel({
    required this.id,
    required this.tableNumber,
    required this.capacity,
    this.location,
    required this.status,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) => _$TableModelFromJson(json);
  Map<String, dynamic> toJson() => _$TableModelToJson(this);

  @override
  List<Object?> get props => [id, tableNumber, capacity, location, status];
}
