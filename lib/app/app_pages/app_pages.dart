import 'package:get/get.dart';
import 'package:sports_trending/app/modules/help_support/bindings/help_support_binding.dart';
import 'package:sports_trending/app/modules/help_support/views/help_support_view.dart';

import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/language/bindings/language_binding.dart';
import '../modules/language/views/language_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/bindings/phone_signup_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/login/views/phone_signup.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/user_profile/bindings/user_profile_binding.dart';
import '../modules/user_profile/views/user_profile_view.dart';

class AppPages {
  AppPages._();

  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const otp = '/otp';
  static const phoneSignUp = '/phoneSignUp';
  static const signup = '/signup';
  static const language = '/language';
  static const profile = '/profile';
  static const userProfile = '/userProfile';
  static const editProfile = '/editProfile';
  static const helpSupport = '/helpSupport';

  static final routes = [
    GetPage(name: splash, page: () => SplashView(), binding: SplashBinding()),
    GetPage(
      name: onboarding,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(name: login, page: () => LoginView(), binding: LoginBinding()),
    GetPage(name: signup, page: () => SignUpView(), binding: SignupBinding()),
    GetPage(
      name: language,
      page:
          () => LanguageView(
            firstName: '',
            lastName: '',
            email: '',
            accessToken: '',
            fromSignup: true,
          ),
      binding: LanguageBinding(),
    ),

    GetPage(
      name: phoneSignUp,
      page: () => PhoneSignUpView(),
      binding: PhoneSignUpBinding(),
    ),
    GetPage(
      name: profile,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),

    GetPage(
      name: userProfile,
      page: () => UserProfileView(),
      binding: UserProfileBinding(),
    ),
    GetPage(
      name: editProfile,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: helpSupport,
      page: () => HelpSupportView(),
      binding: HelpSupportBinding(),
    ),
  ];
}
