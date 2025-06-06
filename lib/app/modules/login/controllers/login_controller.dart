import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sports_trending/app/modules/home/views/home_view.dart';
import 'package:sports_trending/app/modules/login/controllers/otp_verification_controller.dart';
import 'package:sports_trending/app/modules/login/views/login_view.dart';
import 'package:sports_trending/app/modules/login/views/otp_verification.dart';
import 'package:sports_trending/core/shared_preference.dart';
import 'package:sports_trending/model/login/auth_error_model.dart';
import 'package:sports_trending/model/sign_up/sign_up_response.dart';
import 'package:sports_trending/providers/api_provider.dart';
import 'package:sports_trending/utils/internet_controller.dart';
import 'package:twitter_login/twitter_login.dart';

import '../../../../source/color_assets.dart';
import '../../language/controllers/language_controller.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final mobileController = TextEditingController();
  var countryCode = "+91".obs;
  var isPasswordHidden = true.obs;
  var rememberMe = false.obs;
  var selectedIndex = 0.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isLoading = false.obs;
  var errMessage = "".obs;
  Rx<AuthErrorModel?> authError = Rx<AuthErrorModel?>(null);
  DateTime? otpAuthResendTime;
  final internetController = Get.put(InternetController());
  final formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final LanguageController languageController = Get.find();

  @override
  void onClose() {
    // oldPasswordController.dispose();
    // newPasswordController.dispose();
    // confirmPasswordController.dispose();
    super.onClose();
  }

  final ApiProvider apiService = ApiProvider();

  @override
  void onInit() {
    super.onInit();

    checkRememberedUser();
    emailController.text = SharedPref.getString(PrefsKey.email) ?? "";
    passwordController.text = SharedPref.getString(PrefsKey.password) ?? "";
    // print("Loaded Email: ${SharedPref.getString(PrefsKey.email)}"); // Debugging
    // print(
    //   "Loaded Password: ${SharedPref.getString(PrefsKey.password)}",
    // ); // Debugging
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // void toggleRememberMe() {
  //   rememberMe.value = !rememberMe.value;
  // }
  void toggleRememberMe() async {
    rememberMe.value = !rememberMe.value;
    await SharedPref.setValue(PrefsKey.rememberMe, rememberMe.value);

    if (!rememberMe.value) {
      await SharedPref.remove(PrefsKey.email);
      await SharedPref.remove(PrefsKey.password);
    }
  }

  void setSelectedIndex(int val) {
    selectedIndex.value = val;
  }

  Future<void> saveRememberMe(String email, String password) async {
    print("Remember Me Selected: ${rememberMe.value}"); // Debugging

    if (rememberMe.value) {
      await SharedPref.setValue(PrefsKey.rememberMe, true);
      await SharedPref.setValue(PrefsKey.email, email);
      await SharedPref.setValue(PrefsKey.password, password);
      print("Email Saved: $email"); // Debugging
    } else {
      await SharedPref.remove(PrefsKey.rememberMe);
      await SharedPref.remove(PrefsKey.email);
      await SharedPref.remove(PrefsKey.password);
      print("Remember Me Disabled, Email Removed"); // Debugging
    }
  }

  /* Future<void> saveRememberMe(String email, String password) async {
    if (rememberMe.value) {
      await SharedPref.setValue(PrefsKey.rememberMe, true);
      await SharedPref.setValue(PrefsKey.email, email);
      await SharedPref.setValue(PrefsKey.password, password);
    } else {
      await SharedPref.remove(PrefsKey.rememberMe);
    }
  }
*/

  saveUserInfo(SignUpResponseModel signUpResponse) async {
    SharedPref.setValue(PrefsKey.isLoggedIn, true);
    SharedPref.setValue(PrefsKey.userId, signUpResponse.data.id);
    SharedPref.setValue(PrefsKey.fName, signUpResponse.data.firstname);
    SharedPref.setValue(PrefsKey.lName, signUpResponse.data.lastname);
    SharedPref.setValue(PrefsKey.email, signUpResponse.data.email);
    if (signUpResponse.data.phoneNumber.isNotEmpty) {
      SharedPref.setValue(PrefsKey.phoneNo, signUpResponse.data.phoneNumber);
    }
    SharedPref.setValue(PrefsKey.language, signUpResponse.data.language);
    SharedPref.setValue(
      PrefsKey.profilePhoto,
      signUpResponse.data.profileImage,
    );
    SharedPref.setValue(PrefsKey.bio, signUpResponse.data.bio);
    SharedPref.setValue(
      PrefsKey.memberSince,
      signUpResponse.data.createdAt.toIso8601String(),
    );
  }

  Future<void> checkRememberedUser() async {
    bool? isRemembered = SharedPref.getBool(PrefsKey.rememberMe);
    rememberMe.value = isRemembered ?? false;
    if (isRemembered == true) {
      emailController.text = SharedPref.getString(PrefsKey.email) ?? "";
      passwordController.text = SharedPref.getString(PrefsKey.password) ?? "";
      // print(
      //   "Loaded Email: ${SharedPref.getString(PrefsKey.email)}",
      // ); // Debugging
      // print(
      //   "Loaded Password: ${SharedPref.getString(PrefsKey.password)}",
      // ); // Debugging
    }
  }

  Future<void> login() async {
    final isConnected = await internetController.checkInternet();
    if (!isConnected) {
      Get.snackbar(
        languageController.getLabel("internet_error"),
        languageController.getLabel("no_internet_con"),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: Colors.white,
      );
      return;
    }

    if (selectedIndex.value == 0) {
      // Email login
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      if (email.isEmpty || !GetUtils.isEmail(email)) {
        Get.snackbar(
          languageController.getLabel("email_error"),
          languageController.getLabel("valid_email"),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorAssets.error,
          colorText: Colors.white,
        );
        return;
      }

      if (password.isEmpty ||
          password.length < 6 ||
          !isValidPassword(password)) {
        Get.snackbar(
          languageController.getLabel("password_error"),
          languageController.getLabel("pwd_must_lower_char"),
          //  "Password must be at least 6 characters and contain uppercase, lowercase, digit, and special character.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorAssets.error,
          colorText: Colors.white,
        );
        return;
      }

      isLoading(true);
      try {
        final user = await loginWithEmail(email: email, password: password);
        if (user != null) {
          await saveRememberMe(email, password);
          await updateUser(user, isLoginWithEmail: true);
        } else {
          Get.snackbar(
            languageController.getLabel("login_failed"),
            languageController.getLabel("invalid_email_or_password"),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: ColorAssets.error,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        Get.snackbar(
          languageController.getLabel("error"),
          "Login failed: ${e.toString()}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorAssets.error,
          colorText: Colors.white,
        );
      } finally {
        isLoading(false);
      }
    } else {
      // Phone login
      if (otpAuthResendTime == null ||
          DateTime.now().isAfter(otpAuthResendTime!)) {
        final rawPhone = mobileController.text.trim().replaceAll(
          RegExp(r'\s+'),
          '',
        );
        final phone = "${countryCode.value.trim()}$rawPhone";

        if (rawPhone.isEmpty) {
          Get.snackbar(
            languageController.getLabel("validation_error"),

            languageController.getLabel("please_enter_phone_number"),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: ColorAssets.error,
            colorText: Colors.white,
          );
          return;
        }

        await sendOTP(phone);
      } else {
        final remaining =
            otpAuthResendTime!.difference(DateTime.now()).inSeconds;
        Get.snackbar(
          languageController.getLabel("wait"),
          "Please wait $remaining seconds to resend OTP.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorAssets.error,
          colorText: Colors.white,
        );
      }
    }
  }

  Future<void> changePassword() async {
    if (!formKey.currentState!.validate()) return;

    final oldPassword = oldPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final user = _auth.currentUser;

    if (user == null || user.email == null) {
      Get.snackbar(
        languageController.getLabel("error"),
        languageController.getLabel(
          "password_change_is_only_supported_email_login.",
        ),
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
      return;
    }

    if (newPassword != confirmPassword) {
      Get.snackbar(
        languageController.getLabel("error"),
        languageController.getLabel("new_pwd_dnt_match"),
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
      return;
    }

    try {
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      );
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
      await user.reload();

      oldPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();

      Get.snackbar(
        languageController.getLabel("success"),
        languageController.getLabel("please_login"),
        backgroundColor: ColorAssets.themeColorOrange,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      await Future.delayed(const Duration(seconds: 2));
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => LoginView());
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        languageController.getLabel("error"),
        e.message ?? languageController.getLabel("unexpected_error"),

        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    }
  }

  bool isValidPassword(String password) {
    String pattern = r'^(?=.*[a-z])(?=.*\d)[a-zA-Z\d\w\W]{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  Future<void> sendOTP(String phoneNumber, {bool isResend = false}) async {
    isLoading(true);
    await FirebaseAuth.instance.signOut();

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          UserCredential user = await _auth.signInWithCredential(credential);

          debugPrint("Sign Up with phone : $user");
          await updateUser(user);
          Get.offAll(() => HomeView());
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar(
            languageController.getLabel("error"),
            e.message ?? "Verification failed",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          isLoading(false);
        },
        codeSent: (String id, int? resendToken) {
          // verificationId.value = id;
          Get.snackbar(
            languageController.getLabel("success"),
            languageController.getLabel("otp_sent"),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: ColorAssets.themeColorOrange,
            colorText: Colors.white,
          );
          if (isResend) {
            isLoading(false);

            Get.find<OtpVerificationController>().vId = id;
          } else {
            isLoading(false);

            Get.to(
              () =>
                  OtpVerificationView(verificationId: id, phoneNo: phoneNumber),
            )?.then((val) {
              otpAuthResendTime = DateTime.now().add(Duration(seconds: val));
            });
          }
        },
        codeAutoRetrievalTimeout: (String id) {
          //verificationId.value = id;
        },
      );
    } catch (e) {
      Get.snackbar(
        languageController.getLabel("error"),
        "Failed to send OTP ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoading(false);
    }
  }

  Future<UserCredential?> loginWithEmail({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      authError.value = AuthErrorModel.fromFirebaseError(e.code);
      Get.snackbar(
        languageController.getLabel("error"),
        authError.value?.message ?? "",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: Colors.white,
      );
    }
    return null;
  }

  Future<void> logout(context) async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();

    bool? isRemembered = SharedPref.getBool(PrefsKey.rememberMe) ?? false;

    if (!isRemembered) {
      await SharedPref.clearData();
    } else {
      await SharedPref.remove(PrefsKey.isLoggedIn);
      await SharedPref.remove(PrefsKey.userId);
      await SharedPref.remove(PrefsKey.fName);
      await SharedPref.remove(PrefsKey.lName);
      await SharedPref.remove(PrefsKey.phoneNo);
      await SharedPref.remove(PrefsKey.language);
      await SharedPref.remove(PrefsKey.profilePhoto);
      await SharedPref.remove(PrefsKey.bio);
      await SharedPref.remove(PrefsKey.memberSince);
    }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
      (Route<dynamic> route) => false,
    );
  }

  Future<UserCredential?> signInWithYouTube() async {
    isLoading.value = true;
    try {
      // Initiate Google Sign-In process with required YouTube scope
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(
            scopes: [
              'https://www.googleapis.com/auth/youtube.readonly',
              // YouTube Read-Only access
              'https://www.googleapis.com/auth/userinfo.profile',
              // User profile access
              'https://www.googleapis.com/auth/userinfo.email',
              // User email access
            ],
          ).signIn();

      if (googleUser == null) {
        isLoading.value =
            false; // Set loading state to false if user cancels sign-in
        return null; // Return null if user cancels sign-in
      }

      // Retrieve the authentication details from Google
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create the credentials for Firebase Authentication using Google Auth tokens
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with the provided credentials using Firebase Auth
      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      // Successfully signed in, return the UserCredential
      isLoading.value = false; // Set loading state to false
      return userCredential;
    } on FirebaseAuthException catch (e) {
      isLoading(false);
      AuthErrorModel authErrorModel = AuthErrorModel.fromFirebaseError(e.code);
      Get.snackbar(
        languageController.getLabel("error"),
        authErrorModel.message ?? "",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: Colors.white,
      );
      return null; // Return null on error
    } catch (e) {
      // Handle error and show an error message
      isLoading(false);
      Get.snackbar(
        languageController.getLabel("youtb_login"),
        e.toString(),
        snackPosition: SnackPosition.BOTTOM, // Show at the bottom of the screen
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null; // Return null on error
    }
  }

  Future<UserCredential?> signInWithFacebook() async {
    isLoading.value = true;

    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final OAuthCredential credential = FacebookAuthProvider.credential(
          result.accessToken!.token,
        );
        final UserCredential userCredential = await _auth.signInWithCredential(
          credential,
        );
        return userCredential;
      }
      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      isLoading(false);
      AuthErrorModel authErrorModel = AuthErrorModel.fromFirebaseError(e.code);
      Get.snackbar(
        languageController.getLabel("error"),
        authErrorModel.message ?? "",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: Colors.white,
      );
    } catch (e) {
      isLoading.value = false;
      debugPrint("Facebook Login Error: $e");
      Get.snackbar(
        languageController.getLabel("fb_login_e"),
        e.toString(),
        snackPosition: SnackPosition.BOTTOM, // Show at the bottom of the screen
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    return null;
  }

  Future<UserCredential?> signInWithInstagram() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final OAuthCredential credential = FacebookAuthProvider.credential(
          result.accessToken!.token,
        );
        return await _auth.signInWithCredential(credential);
      }
    } catch (e) {
      Get.snackbar(
        languageController.getLabel("insta_login_e"),
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    return null;
  }

  Future<void> youTubeLogin() async {
    UserCredential? user = await signInWithYouTube();

    if (user != null) {
      debugPrint("user youtube : $user");
      updateUser(user);
    }
  }

  Future<void> facebookLogin() async {
    UserCredential? user = await signInWithFacebook();

    if (user != null) {
      debugPrint("user facebook : $user");
      updateUser(user);
    }
  }

  Future<void> updateUser(UserCredential user, {bool? isLoginWithEmail}) async {
    isLoading(true);

    // Safely access the user's displayName and split it
    List<String> nameParts = user.user?.displayName?.trim().split(" ") ?? [];

    // get Id token is equal to ID Token (JWT) for login with emails
    String? accessToken = await user.user?.getIdToken();
    String? refreshAccessToken = user.user?.refreshToken;

    // Use the null-coalescing operator to provide default values if necessary
    await SharedPref.setValue(PrefsKey.accessToken, accessToken);
    await SharedPref.setValue(PrefsKey.refreshToken, refreshAccessToken);
    await SharedPref.setValue(PrefsKey.key_uid, user.user?.uid.toString());

    // Safely assign firstName and lastName, defaulting to an empty string if necessary
    String firstName = nameParts.isNotEmpty ? nameParts[0] : "";
    String lastName =
        nameParts.length > 1 ? nameParts.sublist(1).join(" ") : "";
    // getProfileById();
    try {
      // Call updateUser API, ensuring no null values are passed for email and language
      final response = await apiService.updateUser(
        firstName,
        lastName,
        user.user?.email ?? "",
        user.user?.uid,
        // Default to empty string if email is null
        // Assuming language is always "en", can be modified if dynamic
        // Default empty string for any other field
      );

      // Handle the response after the API call
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final signUpData = SignUpResponseModel.fromJson(responseData);
        await SharedPref.setValue(
          PrefsKey.referralCode,
          responseData["data"]["referralCode"],
        );
        await SharedPref.setValue(
          PrefsKey.userstcoin,
          responseData["data"]["STPoints"].toString(),
        );
        await SharedPref.setValue(
          PrefsKey.userchallengecount,
          responseData["data"]["engagementMetrics"]["Challenges"].toString(),
        );
        // Save the user info using a helper method
        saveUserInfo(signUpData);

        // Show success notification
        Get.snackbar(
          languageController.getLabel("success"),
          languageController.getLabel("login_succ"),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorAssets.themeColorOrange,
          colorText: Colors.white,
        );

        // Redirect to HomeView after a delay
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAll(() => HomeView());
        });
      } else {
        // Handle unsuccessful response if needed
        Get.snackbar(
          languageController.getLabel("error"),
          languageController.getLabel("update_user_info"),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      isLoading(false);
    } catch (e) {
      isLoading(false);

      Get.snackbar(
        languageController.getLabel("error"),
        languageController.getLabel("unexpected_error"),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    isLoading(false);
  }

  Future getProfileById() async {
    final userId = SharedPref.getString(PrefsKey.userId);
    isLoading(true);

    try {
      final response = await apiService.getProfileById(userId);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final signUpData = SignUpResponseModel.fromJson(responseData);
        debugPrint("profile info : $signUpData");
        SharedPref.setValue(PrefsKey.language, signUpData.data.language);
        // Save the user info using a helper method
        //saveUserInfo(signUpData);
        debugPrint("name : ${SharedPref.getString(PrefsKey.fName)}");
      } else {
        Get.snackbar(
          languageController.getLabel("error"),
          languageController.getLabel("user_info"),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      isLoading(false);
    } catch (e) {
      isLoading(false);
      // Catch any errors that occur during the API call or data processing
      Get.snackbar(
        languageController.getLabel("error"),
        languageController.getLabel("unexpected_error"),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> signInWithTwitter() async {
    final twitterLogin = TwitterLogin(
      apiKey: '8QImo3tFTr4W9w0UOg9C0mZ5h',
      apiSecretKey: 'dsFDOpFwSSf57AIIAHNZSayBRekviAZwzSJwCb3rdWt9kCIh6P',
      redirectURI: 'https://sporttrendning.firebaseapp.com/__/auth/handler',
    );

    try {
      final authResult = await twitterLogin.login();

      switch (authResult.status) {
        case TwitterLoginStatus.loggedIn:
          final credential = TwitterAuthProvider.credential(
            accessToken: authResult.authToken!,
            secret: authResult.authTokenSecret!,
          );

          // Sign in to Firebase
          final UserCredential userCredential = await _auth
              .signInWithCredential(credential);

          updateUser(userCredential);
          break;

        // return userCredential;

        case TwitterLoginStatus.cancelledByUser:
          Get.snackbar(
            languageController.getLabel("error"),
            languageController.getLabel("login_cancel"),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: ColorAssets.error,
            colorText: Colors.white,
          );
          break; // return null;

        case TwitterLoginStatus.error:
          Get.snackbar(
            languageController.getLabel("error"),
            languageController.getLabel("login_cancel"),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: ColorAssets.error,
            colorText: Colors.white,
          );
          break; // return null;        // return null;

        default:
          return;
      }
    } on FirebaseAuthException catch (e) {
      isLoading(false);
      AuthErrorModel authErrorModel = AuthErrorModel.fromFirebaseError(e.code);
      Get.snackbar(
        languageController.getLabel("error"),
        authErrorModel.message ?? "",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(languageController.getLabel("twiter_log_e"), e.toString());
    }
  }
}

// class InstagramAuth {
//   static const String clientId = "YOUR_INSTAGRAM_CLIENT_ID";
//   static const String clientSecret = "YOUR_INSTAGRAM_CLIENT_SECRET";
//   static const String redirectUri = "https://www.example.com/auth/instagram/callback";
//
//   static Future<String?> loginWithInstagram() async {
//     final authUrl = "https://api.instagram.com/oauth/authorize"
//         "?client_id=$clientId"
//         "&redirect_uri=$redirectUri"
//         "&scope=user_profile,user_media"
//         "&response_type=code";
//
//     final result = await FlutterWebAuth.authenticate(
//         url: authUrl, callbackUrlScheme: "https");
//
//     final code = Uri.parse(result).queryParameters['code'];
//     if (code == null) return null;
//
//     return _getAccessToken(code);
//   }
//
//   static Future<String?> _getAccessToken(String code) async {
//     final response = await http.post(
//       Uri.parse("https://api.instagram.com/oauth/access_token"),
//       body: {
//         "client_id": clientId,
//         "client_secret": clientSecret,
//         "grant_type": "authorization_code",
//         "redirect_uri": redirectUri,
//         "code": code,
//       },
//     );
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data["access_token"];
//     }
//     return null;
//   }
// }
