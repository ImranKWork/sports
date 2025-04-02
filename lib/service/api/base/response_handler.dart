// import '../base_error.dart';
//
// /// This class is used to handle success and failure of the APIs.
// abstract class ResponseHandler<T> {
//   OnSuccessResponse<T>? getSuccessInstance();
//   OnFailureResponse<T>? getFailureInstance();
//   bool isSuccess();
//   // bool isLoading();
//   bool isFailure();
// }
//
// /// This class is used to represent Success Response.
// ///
// /// Response is handled using generics.
// class OnSuccessResponse<T> extends ResponseHandler<T> {
//   final int? statusCode;
//   final T response;
//
//   OnSuccessResponse({this.statusCode,required this.response});
//
//   /// To avoid type casting everywhere in the app we have added this
//   /// helping method to get instance of [OnFailureResponse] class without heavy type castings.
//   @override
//   OnFailureResponse<T>? getFailureInstance() => null;
//
//   /// To avoid type casting everywhere in the app we have added this
//   /// helping method to get instance of [OnSuccessResponse] class without heavy type castings.
//   @override
//   OnSuccessResponse<T>? getSuccessInstance() => this;
//
//   /// To avoid type casting everywhere in the app we have added this
//   /// helping method to determine directly that it's success or failure instance.
//   @override
//   bool isFailure() => false;
//
//   /// To avoid type casting everywhere in the app we have added this
//   /// helping method to determine directly that it's success or failure instance.
//   @override
//   bool isSuccess() => true;
// }
//
// /// This class is used to represent Failure Response.
// ///
// /// Response is handled using generics.
// class OnFailureResponse<T> extends ResponseHandler<T> {
//   final int? statusCode;
//   final ErrorResult? error;
//
//   OnFailureResponse({this.statusCode, this.error});
//
//   /// To avoid type casting everywhere in the app we have added this
//   /// helping method to get instance of [OnFailureResponse] class without heavy type castings.
//   @override
//   OnFailureResponse<T>? getFailureInstance() => this;
//
//   /// To avoid type casting everywhere in the app we have added this
//   /// helping method to get instance of [OnSuccessResponse] class without heavy type castings.
//   @override
//   OnSuccessResponse<T>? getSuccessInstance() => null;
//
//   /// To avoid type casting everywhere in the app we have added this
//   /// helping method to determine directly that it's success or failure instance.
//   @override
//   bool isFailure() => true;
//
//   /// To avoid type casting everywhere in the app we have added this
//   /// helping method to determine directly that it's success or failure instance.
//   @override
//   bool isSuccess() => false;
// }
//
// // class OnLoading extends ResponseHandler {}