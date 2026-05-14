import 'package:bloc/bloc.dart';
import 'package:customer_app/features/review/domain/repositories/review_repository.dart';
import 'review_event.dart';
import 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepository repository;

  ReviewBloc({required this.repository}) : super(ReviewInitial()) {
    on<LoadProductReviewsRequested>((event, emit) async {
      emit(ReviewLoading());
      final result = await repository.getProductReviews(event.productId);
      result.fold(
        (failure) => emit(ReviewFailure(failure.message)),
        (reviews) => emit(ReviewsLoaded(reviews)),
      );
    });

    on<SubmitReviewRequested>((event, emit) async {
      emit(ReviewLoading());
      final result = await repository.submitReview(
        productId: event.productId,
        rating: event.rating,
        comment: event.comment,
      );
      result.fold(
        (failure) => emit(ReviewFailure(failure.message)),
        (review) => emit(ReviewSubmitSuccess(review)),
      );
    });
  }
}
