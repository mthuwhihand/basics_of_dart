import 'dart:io';

class ApiResponse<T> {
  final T? data;
  final String? message;
  final int status;

  ApiResponse({this.data, this.message, required this.status});

  factory ApiResponse.responseBuilder(String message, T? data, int status) {
    return ApiResponse(
      data: data,
      message: message,
      status: status,
    );
  }
}
