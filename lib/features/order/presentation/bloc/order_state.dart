part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();
  
  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {
  final OrderModel order;
  const OrderSuccess(this.order);

  @override
  List<Object?> get props => [order];
}

class OrderFailure extends OrderState {
  final String message;
  const OrderFailure(this.message);

  @override
  List<Object?> get props => [message];
}
class OrdersLoaded extends OrderState {
  final List<OrderModel> orders;
  const OrdersLoaded(this.orders);

  @override
  List<Object?> get props => [orders];
}
