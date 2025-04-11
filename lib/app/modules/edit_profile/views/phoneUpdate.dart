import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sports_trending/app/modules/edit_profile/controllers/edit_profile_controller.dart';
import 'package:sports_trending/app/modules/home/views/home_view.dart';
import 'package:sports_trending/app/modules/language/controllers/language_controller.dart';
import 'package:sports_trending/app/modules/login/controllers/login_controller.dart';
import 'package:sports_trending/core/shared_preference.dart';
import 'package:sports_trending/model/sign_up/sign_up_response.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/source/styles.dart';
import 'package:sports_trending/utils/screen_util.dart';
import 'package:sports_trending/widgets/common_button.dart';
import 'package:sports_trending/widgets/custom_text_form_field.dart';

class PhoneNumberUpdateScreen extends StatefulWidget {
  String number;
  String ccode;
  int type;
  String codec;

  PhoneNumberUpdateScreen(this.number, this.ccode, this.type, this.codec);
  @override
  State<PhoneNumberUpdateScreen> createState() =>
      _PhoneNumberUpdateScreenState();
}

class _PhoneNumberUpdateScreenState extends State<PhoneNumberUpdateScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  String? _verificationId;
  var isLoading = false;
  bool _otpSent = false;
  var countryCode = "+91";
  var countryN = "IN";
  final LanguageController languageController = Get.find();
  final EditProfileController editProfileController = Get.find();
  void _verifyPhone() async {
    var cc = countryCode + _phoneController.text.trim();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: cc,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto verification
        await FirebaseAuth.instance.currentUser!.updatePhoneNumber(credential);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Phone number updated successfully")),
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Verification failed: ${e.message}")),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
          _otpSent = true;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  void _submitOtp() async {
    isLoading = true;
    setState(() {});
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: _otpController.text.trim(),
      );

      await FirebaseAuth.instance.currentUser!.updatePhoneNumber(credential);
      phoneupdae();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Phone number updated!")));
    } catch (e) {
      isLoading = false;
      setState(() {});
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }

  phoneupdae() async {
    String userId = SharedPref.getString(PrefsKey.userId, "");

    final update = await editProfileController.updateProfile(
      "",
      "",
      "",
      "",
      "",
      _phoneController.text,
      userId,
      "",
      countryCode,
    );

    if (update?.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(update!.body);
      final signUpData = SignUpResponseModel.fromJson(responseData);
      await SharedPref.setValue(PrefsKey.phoneNo, _phoneController.text);
      await SharedPref.setValue(PrefsKey.phoneNocountry, countryCode);

      Get.put(LoginController()).saveUserInfo(signUpData);
      isLoading = false;
      setState(() {});
      Future.delayed(const Duration(seconds: 1), () {
        Get.off(() => HomeView());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == 1) {
      _phoneController.text = widget.number;
      countryN = widget.ccode;
      countryCode = widget.codec;
    }
    return Scaffold(
      appBar: AppBar(title: Text('Update Phone Number')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Constant.size24),
            Text(
              languageController.getLabel("phone_header"),
              style: Styles.textStyleBlackMedium,
            ),
            SizedBox(height: Constant.size16),
            Theme(
              data: ThemeData(
                dividerColor: ColorAssets.themeColorOrange,
                dialogTheme: DialogTheme(backgroundColor: Colors.white),
              ),
              child: IntlPhoneField(
                controller: _phoneController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                initialCountryCode: countryN,
                disableLengthCheck: true,
                showDropdownIcon: true,
                onCountryChanged: ((value) {
                  countryN = value.code.toString();
                  //controller.mobileController.text = "";
                }),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Enter phone (Ex: XXXXXXXXXX)",
                  hintStyle: Styles.textBlackHeader,
                  counterText: "",
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorAssets.themeColorOrange),
                    borderRadius: BorderRadius.circular(Constant.size8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(Constant.size8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),

                    borderRadius: BorderRadius.circular(Constant.size8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(Constant.size8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(Constant.size8),
                  ),
                ),
                onChanged: (phone) {
                  countryCode = phone.countryCode;
                  countryN = phone.countryISOCode.toString();
                },
                validator: (phone) {
                  if (phone == null || phone.number.isEmpty) {
                    return 'Phone number is required';
                  }
                  if (phone.number.length < 10 || phone.number.length > 15) {
                    return 'Enter a valid phone number';
                  }
                  if (!RegExp(r'^\d+$').hasMatch(phone.number)) {
                    return 'Phone number should contain only digits';
                  }
                  return null;
                },
              ),
            ),
            if (_otpSent)
              Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    languageController.getLabel("OTP"),
                    style: Styles.textStyleBlackMedium,
                  ),
                  SizedBox(height: Constant.size16),
                  CustomTextFormField(
                    controller: _otpController,
                    isBorder: true,
                    textInputType: TextInputType.phone,
                    fillColor: Colors.white,

                    borderColor: ColorAssets.lightGreyVariant1,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "OTP is required";
                      }
                      return null;
                    },
                  ),
                ],
              ),

            SizedBox(height: 20),
            isLoading
                ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      ColorAssets.themeColorOrange,
                    ),
                  ),
                )
                : CommonButton(
                  label: _otpSent ? 'Verify OTP & Update' : 'Send OTP',
                  onClick: () {
                    if (_otpSent) {
                      _submitOtp();
                    } else {
                      if (widget.type == 0) {
                        if (widget.number == _phoneController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Same number not be acceptable"),
                            ),
                          );
                        } else {
                          _verifyPhone();
                        }
                      } else {
                        _verifyPhone();
                      }
                    }
                  },
                ),
          ],
        ),
      ),
    );
  }
}
