//
// import 'base_error.dart';
//
// class BaseResponse<T> {
//   final T? response;
//   final int? statusCode;
//   final ErrorResult? error;
//
//   const BaseResponse({this.response, this.statusCode,this.error});
//
//   // create name constructor
//   factory BaseResponse.success(T response) => BaseResponse(response: response);
//   factory BaseResponse.failure(ErrorResult? error,[int? statusCode]) => BaseResponse(error: error,statusCode: statusCode);
//
// }