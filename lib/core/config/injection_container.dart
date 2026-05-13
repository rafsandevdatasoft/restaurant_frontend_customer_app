import 'package:customer_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:customer_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:customer_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:customer_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:customer_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:customer_app/features/menu/data/datasources/menu_remote_data_source.dart';
import 'package:customer_app/features/menu/data/repositories/menu_repository_impl.dart';
import 'package:customer_app/features/menu/domain/repositories/menu_repository.dart';
import 'package:customer_app/features/menu/presentation/bloc/menu_bloc.dart';
import 'package:customer_app/features/order/data/datasources/order_remote_data_source.dart';
import 'package:customer_app/features/order/data/repositories/order_repository_impl.dart';
import 'package:customer_app/features/order/domain/repositories/order_repository.dart';
import 'package:customer_app/features/order/presentation/bloc/cart_bloc.dart';
import 'package:customer_app/features/order/presentation/bloc/order_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(() => AuthBloc(loginUseCase: sl()));
  sl.registerFactory(() => MenuBloc(repository: sl()));
  sl.registerFactory(() => CartBloc());
  sl.registerFactory(() => OrderBloc(repository: sl()));

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<MenuRepository>(
    () => MenuRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton(() => AuthRemoteDataSource(sl()));
  sl.registerLazySingleton(() => MenuRemoteDataSource(sl()));
  sl.registerLazySingleton(() => OrderRemoteDataSource(sl()));

  // Core
  sl.registerLazySingleton(() => Dio());
}
