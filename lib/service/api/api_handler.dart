//
//
// import 'dart:async';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:sports_trending/service/api/base_error.dart';
//
// import 'base/response_handler.dart';
//
// /// we have added one object of this class in Dependency Injection
// /// so kindly do use it (Don't create another one as its not needed)
// /// use Get.find(tag : (ApiHandler).toString()) to access it
//
// class ApiHandler extends GetxService {
//   Dio? _dio;
//   String tag = "API call :";
//   CancelToken? _cancelToken;
//
//   static final ApiHandler _instance = ApiHandler._internal();
//
//   factory ApiHandler({bool isJson = false}) {
// // mDio.options.headers['authorization'] = 'Bearer ';
// // mDio.options.contentType = !isJson
// // ? 'application/json'
// // : 'application/x-www-form-urlencoded';
//
//     return _instance;
//   }
//
//   ApiHandler._internal() {
//     _dio = initApiHandlerDio();
//   }
//
//   Dio initApiHandlerDio() {
//     _cancelToken = CancelToken();
//     final baseOption = BaseOptions(
//       connectTimeout: const Duration(milliseconds: 10 * 1000),
//       receiveTimeout: const Duration(milliseconds: 10 * 1000),
//       baseUrl: AppConstant.apiBaseUrl,
//       contentType: 'application/json',
//
//     );
//     final mDio = Dio(baseOption);
//     if (kDebugMode) {
//       mDio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true, error: true));
//     }
//     mDio.interceptors.add(HttpHandleInterceptor());
//     return mDio;
//   }
//
//   void cancelRequests({CancelToken? cancelToken}) {
//     cancelToken == null ? _cancelToken?.cancel('Cancelled') : cancelToken.cancel();
//   }
//
//   FutureOr<ResponseHandler<T?>> get<T>(
//     String endUrl, {
//     Map<String, dynamic>? params,
//     Options? options,
//     CancelToken? cancelToken,
//     bool showLoader = true,
//     bool dismissLoader = true,
//   }) async {
//     _dio?.options.headers = {'Authorization': 'Bearer ${SharedPref.getString(PrefsKey.accessToken,"")}', "accept": "application/json"};
//     late ResponseHandler<T?> handler;
//     try {
//       _showLoading(showLoader);
//       var isConnected = await _checkInternet();
//       if (!isConnected) {
//         handler = OnFailureResponse(
//           error: ErrorResult(
//             errorMessage: AppString.internetNotConnectedKey.tr,
//             type: ErrorType.noInternetConnection,
//           ),
//         );
//       } else {
//         final response = await _dio?.get<T>(
//           endUrl,
//           queryParameters: params,
//           cancelToken: cancelToken ?? _cancelToken,
//           options: options,
//         );
//         handler = _responseHandler<T>(response);
//       }
//     } on FormatException {
//       handler = OnFailureResponse(
//         error: ErrorResult(
//           errorMessage: AppString.badRequestStateKey.tr,
//           type: ErrorType.other,
//         ),
//       );
//     } on DioException catch (e) {
//       handler = _errorHandler<T>(e);
//     }
//     _dismissLoading(dismissLoader);
//     return handler;
//   }
//
//   FutureOr<ResponseHandler<T?>> post<T>(
//     String endUrl, {
//     Map<String, dynamic>? data,
//     Map<String, dynamic>? params,
//     Options? options,
//     CancelToken? cancelToken,
//     bool isMultipartFormData = false,
//     bool showLoader = true,
//     bool dismissLoader = true,
//   }) async {
//     _dio?.options.headers = {'Authorization': 'Bearer ${SharedPref.getString(PrefsKey.accessToken,"")}', "accept": "application/json"};
//     late ResponseHandler<T?> handler;
//     try {
//       _showLoading(showLoader);
//       var isConnected = await _checkInternet();
//       if (!isConnected) {
//         handler = OnFailureResponse(
//           error: ErrorResult(
//             errorMessage: "Internet not connected",
//             type: ErrorType.noInternetConnection,
//           ),
//         );
//       } else {
//         final response = await (_dio?.post<T>(
//           endUrl,
//           data: isMultipartFormData ? FormData.fromMap(data!) : data,
//           queryParameters: params,
//           cancelToken: cancelToken ?? _cancelToken,
//           options: options,
//         ));
//         handler = _responseHandler<T>(response);
//       }
//     } on FormatException {
//       handler = OnFailureResponse(
//         error: ErrorResult(
//           errorMessage: AppString.badRequestStateKey.tr,
//           type: ErrorType.other,
//         ),
//       );
//     } on DioError catch (e) {
//       handler = _errorHandler(e);
//     }
//     _dismissLoading(dismissLoader);
//     return handler;
//   }
//
//   FutureOr<ResponseHandler<T?>> delete<T>(
//     String endUrl, {
//     Map<String, dynamic>? data,
//     Map<String, dynamic>? params,
//     Options? options,
//     CancelToken? cancelToken,
//   }) async {
//     _dio?.options.headers = {'Authorization': 'Bearer ${SharedPref.getString(PrefsKey.accessToken,"")}', "accept": "application/json"};
//     late ResponseHandler<T?> handler;
//     try {
//       var isConnected = await _checkInternet();
//       if (!isConnected) {
//         handler = OnFailureResponse(
//           error: ErrorResult(
//             errorMessage: AppString.internetNotConnectedKey.tr,
//             type: ErrorType.noInternetConnection,
//           ),
//         );
//       } else {
//         final response = await (_dio?.delete<T>(
//           endUrl,
//           data: data,
//           queryParameters: params,
//           cancelToken: cancelToken ?? _cancelToken,
//           options: options,
//         ));
//         handler = _responseHandler(response);
//       }
//     } on FormatException {
//       handler = OnFailureResponse(
//         error: ErrorResult(
//           errorMessage: AppString.badRequestStateKey.tr,
//           type: ErrorType.other,
//         ),
//       );
//     } on DioError catch (e) {
//       handler = _errorHandler(e);
//     }
//     return handler;
//   }
//
//   ResponseHandler<T?> _responseHandler<T>(Response<T>? response) {
//     if (response?.statusCode == 200 || response?.statusCode == 201) {
//       return OnSuccessResponse(response: response?.data);
//     } else if (response?.statusCode == 401) {
//       SharedPref.clearData();
//       Get.offNamedUntil(AppPages.login, (route) => false);
//       return OnFailureResponse(
//         error: ErrorResult(
//           errorMessage: AppString.unauthorizedKey.tr,
//           type: ErrorType.other,
//         ),
//         statusCode: 401,
//       );
//     } else if (response?.statusCode == 500) {
//       return OnFailureResponse(
//         error: ErrorResult(
//           errorMessage: AppString.serverNotRespondKey.tr,
//           type: ErrorType.serverNotRespond,
//         ),
//         statusCode: 500,
//       );
//     } else {
//       return OnFailureResponse(
//         error: ErrorResult(
//           errorMessage: AppString.somethingWentWrongKey.tr,
//           type: ErrorType.other,
//         ),
//       );
//     }
//   }
//
//   ResponseHandler<T?> _errorHandler<T>(DioException error) {
//     if (error.type == DioExceptionType.badResponse) {
//       return OnFailureResponse(error: ErrorResult.getErrorResult(error.response?.data["message"]));
//     }
//     return OnFailureResponse(error: ErrorResult.getErrorResult(error));
//   }
//
//   void _showLoading(bool showLoader) {
//     if (showLoader) EasyLoading.show();
//   }
//
//   void _dismissLoading(bool dismissLoader) {
//     if (dismissLoader) EasyLoading.dismiss(animation: true);
//   }
//
//   Future<bool> _checkInternet() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult.contains(ConnectivityResult.mobile)) {
//       return true;
//     } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
//       return true;
//     }
//     return false;
//   }
// }
//
// /// you can use this interceptor to change headers, url, requests and responses at runtime
// class HttpHandleInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     /// demo of how can we update header and base url at runtime
//
//     // if (options.path.contains(Apis.login)) {
//     //   options.baseUrl = "https://brainvire.com/V2/";
//     //
//     //   options.headers = {
//     //     'ClientId': "C139304",
//     //     'Authorization':
//     //     'Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJjbGllbnRfaWQiOjE2NSwidXNlcl9pbmZvIjoxLCJpYXQiOjE2MjQ5NzA1NzYsImV4cCI6MTk0MDU0NjU3NiwiYXVkIjoiYXBpLnNhbS5pbmZlZWRvLmNvbSJ9.x2rt5AX4d6HjajHD09ql3NxHFJUkH4cEnEEhm1XMh31clJnLPRPdtpJEnsME1FF2ZrfA7flMHTtrXhIY0oAvZg'
//     //   };
//     // }
//     handler.next(options);
//   }
//
//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) {
//     handler.next(err);
//   }
//
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     handler.next(response);
//   }
//
//   ResponseHandler<T?> _responseHandler<T>(Response<T>? response) {
//     if (response?.statusCode == 200) {
//       return OnSuccessResponse(response: response?.data);
//     } else if (response?.statusCode == 401) {
//       SharedPref.clearData();
//       Get.offNamedUntil(AppPages.login, (route) => false);
//       return OnFailureResponse(
//         error: ErrorResult(
//           errorMessage: AppString.unauthorizedKey.tr,
//           type: ErrorType.other,
//         ),
//         statusCode: 401,
//       );
//     } else if (response?.statusCode == 500) {
//       return OnFailureResponse(
//         error: ErrorResult(
//           errorMessage: AppString.serverNotRespondKey.tr,
//           type: ErrorType.serverNotRespond,
//         ),
//         statusCode: 500,
//       );
//     } else {
//       return OnFailureResponse(
//         error: ErrorResult(
//           errorMessage: AppString.somethingWentWrongKey.tr,
//           type: ErrorType.other,
//         ),
//       );
//     }
//   }
// }
