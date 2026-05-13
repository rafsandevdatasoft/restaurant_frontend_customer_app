import 'package:bloc/bloc.dart';
import 'package:customer_app/features/order/data/models/cart_item_model.dart';
import 'package:customer_app/features/order/data/models/order_model.dart';
import 'package:customer_app/features/order/domain/repositories/order_repository.dart';
import 'package:equatable/equatable.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository repository;

  OrderBloc({required this.repository}) : super(OrderInitial()) {
    on<PlaceOrderRequested>((event, emit) async {
      emit(OrderLoading());
      
      final items = event.cartItems.map((item) => {
        "productId": item.product.id,
        "quantity": item.quantity,
      }).toList();

      final result = await repository.placeOrder(
        items: items,
        orderType: event.orderType,
        addressId: event.addressId,
        specialInstructions: event.specialInstructions,
      );

      result.fold(
        (failure) => emit(OrderFailure(failure.message)),
        (order) => emit(OrderSuccess(order)),
      );
    });
  }
}
