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

  // bool hasData() => data != null;

  // bool hasError() => error != null;

  // bool isSuccess() => success;

  // bool isError() => !success;

  // T getData() {
  //   if (success && data != null) {
  //     return data!;
  //   } else {
  //     throw Exception(error ?? 'Unknown error occurred');
  //   }
  // }

  // String getError() {
  //   if (!success && error != null) {
  //     return error!;
  //   } else {
  //     return 'No error message available';
  //   }
  // }
}
