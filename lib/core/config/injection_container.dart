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
import 'package:customer_app/features/booking/data/datasources/booking_remote_data_source.dart';
import 'package:customer_app/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:customer_app/features/booking/domain/repositories/booking_repository.dart';
import 'package:customer_app/features/booking/domain/usecases/create_booking.dart';
import 'package:customer_app/features/booking/domain/usecases/get_available_tables.dart';
import 'package:customer_app/features/booking/domain/usecases/get_my_bookings.dart';
import 'package:customer_app/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:customer_app/features/review/data/datasources/review_remote_data_source.dart';
import 'package:customer_app/features/review/data/repositories/review_repository_impl.dart';
import 'package:customer_app/features/review/domain/repositories/review_repository.dart';
import 'package:customer_app/core/error/error_interceptor.dart';
import 'package:customer_app/features/review/presentation/bloc/review_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(() => AuthBloc(loginUseCase: sl()));
  sl.registerFactory(() => MenuBloc(repository: sl()));
  sl.registerFactory(() => CartBloc());
  sl.registerFactory(() => OrderBloc(repository: sl()));
  sl.registerFactory(() => BookingBloc(
        createBooking: sl(),
        getMyBookings: sl(),
        getAvailableTables: sl(),
      ));
  sl.registerFactory(() => ReviewBloc(repository: sl()));

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => CreateBooking(sl()));
  sl.registerLazySingleton(() => GetMyBookings(sl()));
  sl.registerLazySingleton(() => GetAvailableTables(sl()));

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
  sl.registerLazySingleton<BookingRepository>(
    () => BookingRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ReviewRepository>(
    () => ReviewRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton(() => AuthRemoteDataSource(sl()));
  sl.registerLazySingleton(() => MenuRemoteDataSource(sl()));
  sl.registerLazySingleton(() => OrderRemoteDataSource(sl()));
  sl.registerLazySingleton(() => BookingRemoteDataSource(sl()));
  sl.registerLazySingleton(() => ReviewRemoteDataSource(sl()));

  // Core
  sl.registerLazySingleton(() {
    final dio = Dio();
    dio.interceptors.add(ErrorInterceptor());
    return dio;
  });
}
