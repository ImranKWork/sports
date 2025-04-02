import 'package:flutter/foundation.dart';

class AuthErrorModel {
  final String errorCode;
  final String message;

  AuthErrorModel({required this.errorCode, required this.message});

  // Convert Firebase error codes to readable messages
  factory AuthErrorModel.fromFirebaseError(String errorCode) {
    String message;
    debugPrint("error : $errorCode");
    switch (errorCode) {
      case "invalid-email":
        message = "Invalid email format.";
        break;
      case "user-not-found":
        message = "No user found with this email.";
        break;
      case "wrong-password":
        message = "Incorrect password.";
        break;
      case "invalid-credential":
        message = "Invalid credential.";
        break;
      case "email-already-in-use":
        message = "Email is already registered.";
        break;
      case "weak-password":
        message = "Password is too weak.";
        break;
      case "network-request-failed":
        message = "No internet connection.";
        break;
      case "too-many-requests":
        message = "Too many attempts. Please try again later.";
        break;
      case "operation-not-allowed":
        message = "Operation not allowed. Please contact support.";
        break;
      case "user-disabled":
        message = "Your account has been disabled.";
        break;
      case "account-exists-with-different-credential":
        message = "An account already exists with the same email but different sign-in credentials.";
        break;
      case "requires-recent-login":
        message = "This operation requires recent login. Please log in again.";
        break;
      case "auth/invalid-verification-code":
        message = "Invalid verification code.";
        break;
      case "auth/invalid-verification-id":
        message = "Invalid verification ID.";
        break;
      case "auth/credential-already-in-use":
        message = "This credential is already associated with another account.";
        break;
      case "auth/invalid-api-key":
        message = "The API key is invalid.";
        break;
      case "auth/missing-android-pkg-name":
        message = "Missing Android package name.";
        break;
      case "auth/missing-continue-uri":
        message = "Missing continue URL.";
        break;
      case "auth/missing-ios-bundle-id":
        message = "Missing iOS bundle ID.";
        break;
      case "auth/unauthorized-continue-uri":
        message = "Unauthorized continue URL.";
        break;
      case "auth/invalid-dynamic-link-domain":
        message = "Invalid dynamic link domain.";
        break;
      case "auth/wrong-password":
        message = "Incorrect password.";
        break;
      case "auth/email-already-in-use":
        message = "Email is already in use.";
        break;
      case "auth/invalid-email":
        message = "Invalid email format.";
        break;
      case "auth/user-disabled":
        message = "The user account has been disabled.";
        break;
      case "auth/user-not-found":
        message = "No user found with this email.";
        break;
      case "auth/too-many-requests":
        message = "Too many requests. Please try again later.";
        break;
      case "auth/operation-not-allowed":
        message = "This operation is not allowed. Please contact support.";
        break;
      case "auth/weak-password":
        message = "The password is too weak.";
        break;
      case "auth/popup-closed-by-user":
        message = "Popup closed by the user.";
        break;
      case "auth/cancelled-popup-request":
        message = "The popup request was cancelled.";
        break;
      case "auth/popup-blocked":
        message = "Popup blocked. Please allow popups in your browser.";
        break;
      case "auth/redirect-cancelled-by-user":
        message = "Redirect operation was cancelled by the user.";
        break;
      case "auth/redirect-blocked":
        message = "Redirect blocked. Please check the configuration.";
        break;
      default:
        message = "An unknown error occurred.";
    }
    return AuthErrorModel(errorCode: errorCode, message: message);
  }
}