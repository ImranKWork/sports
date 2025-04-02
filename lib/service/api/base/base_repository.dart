//
//
// import 'package:get/get.dart';
// import 'package:sports_trending/service/api/api_handler.dart';
//
// import 'response_handler.dart';
//
// abstract class BaseRepository  {
//
//   final ApiHandler apiClient = Get.find(tag: (ApiHandler).toString());
//
//   /// Generic Parser Function.
//   ///
//   /// This function will check for Success And Failure and parse the response
//   /// in the Defined generic T type.
//   ResponseHandler<T> getParsedResponseHandler<T>({
//     required ResponseHandler<Map<String, dynamic>?> responseHandler,
//     required T Function(Map<String, dynamic> value) parser,
//   }) {
//     if (responseHandler.isSuccess()) {
//       final parsedData =
//       parser.call(responseHandler.getSuccessInstance()?.response ?? {});
//       return OnSuccessResponse<T>(response: parsedData);
//     } else {
//       return OnFailureResponse(
//         statusCode: responseHandler.getFailureInstance()?.statusCode,
//         error: responseHandler.getFailureInstance()?.error,
//       );
//     }
//   }
// }