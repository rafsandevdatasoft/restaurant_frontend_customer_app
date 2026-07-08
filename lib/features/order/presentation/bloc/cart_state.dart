part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<CartItemModel> items;
  final String? appliedCouponCode;
  final double discountValue;
  final bool isLoadingCoupon;
  final String? couponError;
  
  const CartState({
    this.items = const [],
    this.appliedCouponCode,
    this.discountValue = 0.0,
    this.isLoadingCoupon = false,
    this.couponError,
  });

  double get subtotal => items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  double get totalPrice => (subtotal - discountValue) > 0 ? (subtotal - discountValue) : 0;
  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  CartState copyWith({
    List<CartItemModel>? items,
    String? appliedCouponCode,
    double? discountValue,
    bool? isLoadingCoupon,
    String? couponError,
  }) {
    return CartState(
      items: items ?? this.items,
      appliedCouponCode: appliedCouponCode, // Can't easily set to null if not provided, but good enough
      discountValue: discountValue ?? this.discountValue,
      isLoadingCoupon: isLoadingCoupon ?? this.isLoadingCoupon,
      couponError: couponError, // Overwrite with null if not provided
    );
  }

  @override
  List<Object?> get props => [items, appliedCouponCode, discountValue, isLoadingCoupon, couponError];
}
