import 'package:customer_app/core/config/api_config.dart';
import 'package:customer_app/features/booking/data/models/booking_model.dart';
import 'package:customer_app/features/booking/data/models/table_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'booking_remote_data_source.g.dart';

@RestApi(baseUrl: ApiConfig.baseUrl)
abstract class BookingRemoteDataSource {
  factory BookingRemoteDataSource(Dio dio, {String baseUrl}) = _BookingRemoteDataSource;

  @POST("/bookings")
  Future<BookingModel> createBooking(@Body() Map<String, dynamic> body);

  @GET("/bookings/my")
  Future<List<BookingModel>> getMyBookings();

  @GET("/bookings/tables")
  Future<List<TableModel>> getAvailableTables();
}
