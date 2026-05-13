part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class PlaceOrderRequested extends OrderEvent {
  final List<CartItemModel> cartItems;
  final String orderType;
  final int? addressId;
  final String? specialInstructions;

  const PlaceOrderRequested({
    required this.cartItems,
    required this.orderType,
    this.addressId,
    this.specialInstructions,
  });

  @override
  List<Object?> get props => [cartItems, orderType, addressId, specialInstructions];
}
