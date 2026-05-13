part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object?> get props => [];
}

class LoadMenuRequested extends MenuEvent {
  final int? categoryId;
  final String? search;

  const LoadMenuRequested({this.categoryId, this.search});

  @override
  List<Object?> get props => [categoryId, search];
}
