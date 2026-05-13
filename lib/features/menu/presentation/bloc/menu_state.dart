part of 'menu_bloc.dart';

abstract class MenuState extends Equatable {
  const MenuState();
  
  @override
  List<Object?> get props => [];
}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final List<CategoryModel> categories;
  final List<ProductModel> products;
  
  const MenuLoaded({required this.categories, required this.products});

  @override
  List<Object?> get props => [categories, products];
}

class MenuError extends MenuState {
  final String message;
  const MenuError({required this.message});

  @override
  List<Object?> get props => [message];
}
