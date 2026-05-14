import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String message;
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = "Connection timed out. Please check your internet.";
        break;
      case DioExceptionType.badResponse:
        message = _handleBadResponse(err.response);
        break;
      case DioExceptionType.cancel:
        message = "Request was cancelled.";
        break;
      case DioExceptionType.connectionError:
        message = "No internet connection.";
        break;
      default:
        message = "Something went wrong. Please try again.";
    }
    
    // You could use a global navigator key to show a snackbar here
    print("API ERROR: $message");
    
    super.onError(err.copyWith(message: message), handler);
  }

  String _handleBadResponse(Response? response) {
    if (response == null) return "Unexpected error occurred.";
    switch (response.statusCode) {
      case 400: return "Bad request. Please check your data.";
      case 401: return "Unauthorized. Please login again.";
      case 403: return "Forbidden. You don't have permission.";
      case 404: return "Resource not found.";
      case 500: return "Internal server error. Try again later.";
      default: return "Error ${response.statusCode}: ${response.statusMessage}";
    }
  }
}
