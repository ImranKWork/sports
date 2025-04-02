// ignore: avoid_classes_with_only_static_members
abstract class RegExpressions {
  static final RegExp email = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final RegExp phoneNumber = RegExp(r'(^[0-9]{6,14}$)');
  static final RegExp password =  RegExp(r'^(?=.*[a-z])(?=.*\d)[a-zA-Z\d\w\W]{8,}$');
  // static final RegExp regExpPsw = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  static final RegExp yearStartingFrom1960 = RegExp(r'^(19[6-9][0-9]|20[0-2][0-9]|20[3-9])$');
}