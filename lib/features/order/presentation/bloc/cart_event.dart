part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class AddToCartRequested extends CartEvent {
  final ProductModel product;
  const AddToCartRequested(this.product);

  @override
  List<Object?> get props => [product];
}

class RemoveFromCartRequested extends CartEvent {
  final int productId;
  const RemoveFromCartRequested(this.productId);

  @override
  List<Object?> get props => [productId];
}

class UpdateQuantityRequested extends CartEvent {
  final int productId;
  final int quantity;
  const UpdateQuantityRequested(this.productId, this.quantity);

  @override
  List<Object?> get props => [productId, quantity];
}

class ClearCartRequested extends CartEvent {}

class ApplyCouponRequested extends CartEvent {
  final String code;
  const ApplyCouponRequested(this.code);

  @override
  List<Object?> get props => [code];
}

class RemoveCouponRequested extends CartEvent {}
