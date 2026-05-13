import 'package:bloc/bloc.dart';
import 'package:customer_app/features/menu/data/models/category_model.dart';
import 'package:customer_app/features/menu/data/models/product_model.dart';
import 'package:customer_app/features/menu/domain/repositories/menu_repository.dart';
import 'package:equatable/equatable.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MenuRepository repository;

  MenuBloc({required this.repository}) : super(MenuInitial()) {
    on<LoadMenuRequested>((event, emit) async {
      emit(MenuLoading());
      
      final categoriesResult = await repository.getCategories();
      final productsResult = await repository.getProducts(
        categoryId: event.categoryId,
        search: event.search,
      );

      categoriesResult.fold(
        (failure) => emit(MenuError(message: failure.message)),
        (categories) {
          productsResult.fold(
            (failure) => emit(MenuError(message: failure.message)),
            (products) => emit(MenuLoaded(categories: categories, products: products)),
          );
        },
      );
    });
  }
}
