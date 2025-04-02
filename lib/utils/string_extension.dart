import 'dart:convert';

import 'package:sports_trending/utils/reg_expressions.dart';



extension Util on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isNotNullOrEmpty => !isNullOrEmpty;

  bool get isBlank => this == null || this!.trim().isEmpty;

  bool get isNotBlank => !isBlank;

  bool get isNullOrBlank => this == null || isBlank;

  bool get isNotNullOrBlank => !isNullOrBlank;

  bool get isValidEmail => RegExpressions?.email.hasMatch(this ?? '');

  bool get isValidPhoneNumber => RegExpressions.phoneNumber.hasMatch(this ?? '');

  bool get isValidPassword => RegExpressions.password.hasMatch(this ?? '');

  String get toTitleCase => this == null ? '' : '${this![0].toUpperCase()}${this!.substring(1)}';

  String get toBase64 => base64.encode(utf8.encode(this ?? ''));
}

extension ListUtil on List<String> {
  String get joinToString => reduce((curr, next) => '$curr,$next');
}

extension TextFieldValidator on String {
  String? validateFirstName() {
    if (isEmpty) {
      return "Please enter first name";
    } else if (length >= 2) {
      return null;
    } else {
      return "Invalid first name";
    }
  }

  String? validateMobileNumber() {
    if (isEmpty) {
      return "Please enter a mobile number";
    } else if (RegExp(r'^[0-9]{10}$').hasMatch(this)) {
      return null;
    } else {
      return "Enter a valid 10-digit mobile number";
    }
  }

  String? validateLastName() {
    if (isEmpty) {
      return "Please enter last name";
    } else if (length >= 2) {
      return null;
    } else {
      return "Invalid last name";
    }
  }

  String? validateEmail() {
    if (isEmpty) {
      return "Please enter emailId";
    } else if (!RegExpressions.email.hasMatch(this)) {
      return "Please enter valid emailId";
    }
    return null;
  }

  String? validatePassword() {
    if (isEmpty) {
      return "Please enter password";
    } else if (!RegExpressions.password.hasMatch(this)) {
      return "Password should 8 character long and should contain one upper one lower character one digit and one special character.";
    } else {
      return null;
    }
  }

  String? validateIsEmpty(String errorMessage) {
    if (isEmpty || isNullOrEmpty) {
      return errorMessage;
    }
    return null;
  }

  String? validateIfEndYearIsValid(String start) {
    if (start.isEmpty) {
      return "Enter valid year";
    } else if (isEmpty) {
      return "Enter valid year";
    } else {
      if (this != "Present") {
        var startYear = int.parse(start);
        var endYear = int.parse(this);
        if (startYear > endYear || endYear > DateTime.now().year) {
          return "Enter valid year";
        }
      }
    }
    return null;
  }

  String? validateIfStartYearIsValid(String end) {
    if (end.isEmpty) {
      return "Enter valid year";
    } else if (isEmpty) {
      return "Enter valid year";
    } else {
      if (end != "Present") {
        var endYear = int.parse(end);
        var startYear = int.parse(this);
        if (startYear > endYear || startYear > DateTime.now().year) {
          return "Enter valid year";
        }
      }
      return null;
    }
  }
}
