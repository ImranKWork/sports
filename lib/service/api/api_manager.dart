//
//
//
// import 'package:get/get.dart';
// import 'package:sports_trending/service/api/api_handler.dart';
//
//
// /// define all of your api calls here
// /// this class is also included in ViewControllerBase Controller
// /// you can use it to call apis from there
//
// class ApiManager extends GetxService {
//   factory ApiManager() {
//     return _instance;
//   }
//
//   static final ApiManager _instance = ApiManager._internal();
//
//   ApiManager._internal();
//
//   final ApiHandler _apiHandler = Get.find(tag: (ApiHandler).toString());
//
//   /*Future<ResLogin> login(String _userName, String _password) async {
//     try {
//       final response = await _apiHandler.post(
//         Apis.login,
//         data: {'username': _userName, 'password': _password},
//       );
//       if(response?.response != null){
//         return ResLogin.fromJson(response?.response);
//       }else{
//         return response.error
//       }
//     } on DioError catch (error) {
//       throw BaseModel.fromJson(error.response?.data);
//     }
//   }
//
//   Future<ResLogin> getData() async {
//     try {
//       final response = await _apiHandler.get(
//         Apis.signUp,
//         params: {
//           'q': 'anim',
//           'from': '2020-08-25',
//           'sortBy': 'publishedAt',
//           'language': 'en',
//           'apiKey': "98c8df982b8b4da8b86cd70e851fc521"
//         },
//       );
//       return ResLogin.fromJson(response?.response);
//     } on DioError catch (error) {
//       throw BaseModel.fromJson(error.response?.data);
//     }
//   }*/
// }
