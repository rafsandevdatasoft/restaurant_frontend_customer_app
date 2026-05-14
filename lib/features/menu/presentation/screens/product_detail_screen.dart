import 'package:customer_app/features/menu/data/models/product_model.dart';
import 'package:customer_app/features/order/presentation/bloc/cart_bloc.dart';
import 'package:customer_app/features/order/presentation/screens/cart_screen.dart';
import 'package:customer_app/features/review/presentation/bloc/review_bloc.dart';
import 'package:customer_app/features/review/presentation/bloc/review_event.dart';
import 'package:customer_app/features/review/presentation/bloc/review_state.dart';
import 'package:customer_app/features/review/presentation/widgets/review_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CartScreen()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.imageUrls != null && product.imageUrls!.isNotEmpty)
              Image.network(
                product.imageUrls!.first,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              )
            else
              Container(
                width: double.infinity,
                height: 250,
                color: Colors.orange.shade100,
                child: const Icon(Icons.fastfood, size: 100, color: Colors.orange),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      if (product.isPopular)
                        Chip(
                          label: const Text('Popular'),
                          backgroundColor: Colors.orange.shade50,
                          labelStyle: const TextStyle(color: Colors.orange),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description ?? 'No description available.',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Options',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const ListTile(
                    title: Text('Spice Level'),
                    trailing: Icon(Icons.chevron_right),
                  ),
                  const ListTile(
                    title: Text('Extra Toppings'),
                    trailing: Icon(Icons.chevron_right),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Reviews',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextButton.icon(
                        onPressed: () => _showReviewDialog(context),
                        icon: const Icon(Icons.add_comment),
                        label: const Text('Write a Review'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ReviewListWidget(productId: product.id),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            context.read<CartBloc>().add(AddToCartRequested(product));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${product.name} added to cart'),
                action: SnackBarAction(
                  label: 'View Cart',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CartScreen()));
                  },
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: const Text('Add to Cart', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  void _showReviewDialog(BuildContext context) {
    int rating = 5;
    final commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Write a Review'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => IconButton(
                    onPressed: () => setState(() => rating = index + 1),
                    icon: Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: commentController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Share your thoughts...',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<ReviewBloc>().add(SubmitReviewRequested(
                      productId: product.id,
                      rating: rating,
                      comment: commentController.text,
                    ));
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Review submitted for moderation!')),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
