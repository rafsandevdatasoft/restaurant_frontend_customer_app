import 'package:bloc/bloc.dart';
import 'package:customer_app/features/menu/data/models/product_model.dart';
import 'package:customer_app/features/order/data/models/cart_item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final Dio _dio = Dio();

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

    on<ApplyCouponRequested>((event, emit) async {
      emit(state.copyWith(isLoadingCoupon: true, couponError: null));
      try {
        final subtotal = state.subtotal;
        if (subtotal == 0) {
          emit(state.copyWith(isLoadingCoupon: false, couponError: "Cart is empty"));
          return;
        }

        final response = await _dio.get(
          'http://localhost:8080/api/coupons/validate',
          queryParameters: {
            'code': event.code,
            'orderTotal': subtotal,
          },
        );

        if (response.statusCode == 200) {
          final data = response.data;
          double discountValue = 0.0;
          if (data['discountType'] == 'PERCENTAGE') {
            discountValue = subtotal * (data['discountValue'] / 100);
          } else {
            discountValue = data['discountValue'];
          }

          emit(state.copyWith(
            isLoadingCoupon: false,
            appliedCouponCode: event.code,
            discountValue: discountValue,
            couponError: null,
          ));
        }
      } catch (e) {
        String error = "Invalid or expired coupon";
        if (e is DioException && e.response != null && e.response?.data != null) {
          error = e.response?.data['message'] ?? error;
        }
        emit(state.copyWith(isLoadingCoupon: false, couponError: error, discountValue: 0.0, appliedCouponCode: null));
      }
    });

    on<RemoveCouponRequested>((event, emit) {
      emit(state.copyWith(appliedCouponCode: null, discountValue: 0.0, couponError: null));
    });
  }
}
