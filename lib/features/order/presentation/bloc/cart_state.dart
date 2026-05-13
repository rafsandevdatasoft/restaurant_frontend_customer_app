part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<CartItemModel> items;
  
  const CartState({this.items = const []});

  double get totalPrice => items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  @override
  List<Object?> get props => [items];
}
