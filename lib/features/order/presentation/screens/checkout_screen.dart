import 'package:customer_app/features/order/presentation/bloc/cart_bloc.dart';
import 'package:customer_app/features/order/presentation/bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _orderType = 'DELIVERY';
  final _instructionsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderSuccess) {
            context.read<CartBloc>().add(ClearCartRequested());
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: const Text('Order Placed!'),
                content: Text('Your order #${state.order.id} has been placed successfully.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: const Text('Go Home'),
                  ),
                ],
              ),
            );
          } else if (state is OrderFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Order Type', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              RadioListTile<String>(
                title: const Text('Delivery'),
                value: 'DELIVERY',
                groupValue: _orderType,
                onChanged: (value) => setState(() => _orderType = value!),
              ),
              RadioListTile<String>(
                title: const Text('Pickup'),
                value: 'PICKUP',
                groupValue: _orderType,
                onChanged: (value) => setState(() => _orderType = value!),
              ),
              const SizedBox(height: 24),
              const Text('Special Instructions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: _instructionsController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Any special requests?',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32),
              const Text('Order Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      ...state.items.map((item) => ListTile(
                            title: Text(item.product.name),
                            trailing: Text('\$${(item.product.price * item.quantity).toStringAsFixed(2)}'),
                            subtitle: Text('Qty: ${item.quantity}'),
                          )),
                      const Divider(),
                      ListTile(
                        title: const Text('Total Amount', style: TextStyle(fontWeight: FontWeight.bold)),
                        trailing: Text(
                          '\$${state.totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            return ElevatedButton(
              onPressed: state is OrderLoading
                  ? null
                  : () {
                      final cartItems = context.read<CartBloc>().state.items;
                      context.read<OrderBloc>().add(PlaceOrderRequested(
                            cartItems: cartItems,
                            orderType: _orderType,
                            specialInstructions: _instructionsController.text,
                          ));
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: state is OrderLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Place Order', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            );
          },
        ),
      ),
    );
  }
}
