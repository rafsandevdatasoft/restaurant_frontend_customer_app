import 'package:customer_app/features/order/presentation/bloc/cart_bloc.dart';
import 'package:customer_app/features/order/presentation/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _couponController = TextEditingController();

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const Center(child: Text('Your cart is empty.'));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(item.quantity.toString()),
                        ),
                        title: Text(item.product.name),
                        subtitle: Text('\$${(item.product.price * item.quantity).toStringAsFixed(2)}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                context.read<CartBloc>().add(UpdateQuantityRequested(item.product.id, item.quantity - 1));
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                context.read<CartBloc>().add(UpdateQuantityRequested(item.product.id, item.quantity + 1));
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5)),
                  ],
                ),
                child: Column(
                  children: [
                    // Promo Code Section
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _couponController,
                            decoration: InputDecoration(
                              hintText: 'Enter Promo Code',
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.orange),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: state.isLoadingCoupon || state.items.isEmpty
                              ? null
                              : () {
                                  if (_couponController.text.trim().isNotEmpty) {
                                    context.read<CartBloc>().add(ApplyCouponRequested(_couponController.text.trim()));
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange.shade100,
                            foregroundColor: Colors.orange.shade800,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: state.isLoadingCoupon 
                              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                              : const Text('Apply', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    if (state.couponError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(state.couponError!, style: const TextStyle(color: Colors.red, fontSize: 12)),
                        ),
                      ),
                    if (state.appliedCouponCode != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Coupon (${state.appliedCouponCode}) applied!', style: const TextStyle(color: Colors.green, fontSize: 14)),
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.red, size: 16),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () {
                                context.read<CartBloc>().add(RemoveCouponRequested());
                                _couponController.clear();
                              },
                            )
                          ],
                        ),
                      ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('\$${state.totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('Checkout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
