import 'package:customer_app/features/review/presentation/bloc/review_bloc.dart';
import 'package:customer_app/features/review/presentation/bloc/review_event.dart';
import 'package:customer_app/features/review/presentation/bloc/review_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewListWidget extends StatelessWidget {
  final int productId;

  const ReviewListWidget({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewBloc, ReviewState>(
      builder: (context, state) {
        if (state is ReviewLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ReviewsLoaded) {
          final reviews = state.reviews;
          if (reviews.isEmpty) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(child: Text('No reviews yet. Be the first to review!')),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          review.customerName ?? 'Anonymous',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Row(
                          children: List.generate(
                            5,
                            (i) => Icon(
                              Icons.star,
                              size: 16,
                              color: i < review.rating ? Colors.orange : Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(review.comment),
                    const Divider(),
                  ],
                ),
              );
            },
          );
        } else if (state is ReviewFailure) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }
}
