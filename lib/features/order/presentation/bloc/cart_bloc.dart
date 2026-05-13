import 'package:bloc/bloc.dart';
import 'package:customer_app/features/menu/data/models/product_model.dart';
import 'package:customer_app/features/order/data/models/cart_item_model.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddToCartRequested>((event, emit) {
      final items = List<CartItemModel>.from(state.items);
      final index = items.indexWhere((item) => item.product.id == event.product.id);
      
      if (index >= 0) {
        items[index] = items[index].copyWith(quantity: items[index].quantity + 1);
      } else {
        items.add(CartItemModel(product: event.product, quantity: 1));
      }
      emit(CartState(items: items));
    });

    on<RemoveFromCartRequested>((event, emit) {
      final items = state.items.where((item) => item.product.id != event.productId).toList();
      emit(CartState(items: items));
    });

    on<UpdateQuantityRequested>((event, emit) {
      final items = List<CartItemModel>.from(state.items);
      final index = items.indexWhere((item) => item.product.id == event.productId);
      
      if (index >= 0) {
        if (event.quantity <= 0) {
          items.removeAt(index);
        } else {
          items[index] = items[index].copyWith(quantity: event.quantity);
        }
        emit(CartState(items: items));
      }
    });

    on<ClearCartRequested>((event, emit) {
      emit(const CartState());
    });
  }
}
