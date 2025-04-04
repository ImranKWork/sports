import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_trending/app/modules/login/controllers/login_controller.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/image_assets.dart';
import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../../../../widgets/common_button.dart';
import '../../../../widgets/common_header.dart';
import '../../../../widgets/custom_text_form_field.dart';

class ChangePasswd extends StatefulWidget {
  const ChangePasswd({super.key});

  @override
  State<ChangePasswd> createState() => _ChangePasswdState();
}

class _ChangePasswdState extends State<ChangePasswd> {
  final LoginController loginController = Get.find<LoginController>();

  bool _isOldHidden = true;
  bool _isNewHidden = true;
  bool _isConfirmHidden = true;

  @override
  void initState() {
    super.initState();
    loginController.oldPasswordController.text = '';
    loginController.newPasswordController.text = '';
    loginController.confirmPasswordController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      backgroundColor: ColorAssets.white,
      appBar: CommonAppBar(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset("assets/images/back.png", scale: 2.2),
                ),
                SizedBox(width: Constant.size30),
                Text(
                  "Change Password",
                  style: Styles.textStyleBlackMedium.copyWith(
                    color: ColorAssets.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: loginController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Constant.size10),
                Text("Old Password", style: Styles.textBlackHeader),
                SizedBox(height: Constant.size15),
                CustomTextFormField(
                  input: TextInputAction.done,
                  textInputType: TextInputType.text,
                  controller: loginController.oldPasswordController,
                  obscureText: _isOldHidden,
                  placeHolder: "Enter Password",
                  hintStyle: Styles.textStyleWhite14.copyWith(fontSize: 10),
                  suffixOnClick: () {
                    setState(() {
                      _isOldHidden = !_isOldHidden;
                    });
                  },
                  suffixIcon:
                      _isOldHidden
                          ? ImageAssets.passwordHide
                          : ImageAssets.passwordShow,
                  validator:
                      (value) =>
                          value!.isEmpty ? "Please enter old password" : null,
                  isBorder: true,
                  borderColor: ColorAssets.grey,
                ),
                SizedBox(height: Constant.size20),
                Text("New Password", style: Styles.textBlackHeader),
                SizedBox(height: Constant.size15),
                CustomTextFormField(
                  input: TextInputAction.done,
                  textInputType: TextInputType.text,
                  controller: loginController.newPasswordController,
                  obscureText: _isNewHidden,
                  placeHolder: "Enter New Password",
                  hintStyle: Styles.textStyleWhite14.copyWith(fontSize: 12),
                  suffixOnClick: () {
                    setState(() {
                      _isNewHidden = !_isNewHidden;
                    });
                  },
                  suffixIcon:
                      _isNewHidden
                          ? ImageAssets.passwordHide
                          : ImageAssets.passwordShow,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter new password";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    if (!loginController.isValidPassword(value)) {
                      return "Password must have upper, lower, digit, special char";
                    }
                    return null;
                  },
                  isBorder: true,
                  borderColor: ColorAssets.grey,
                ),
                SizedBox(height: Constant.size20),
                Text("Confirm New Password", style: Styles.textBlackHeader),
                SizedBox(height: Constant.size15),
                CustomTextFormField(
                  input: TextInputAction.done,
                  textInputType: TextInputType.text,
                  controller: loginController.confirmPasswordController,
                  obscureText: _isConfirmHidden,
                  placeHolder: "Confirm New Password",
                  hintStyle: Styles.textStyleWhite14.copyWith(fontSize: 12),
                  suffixOnClick: () {
                    setState(() {
                      _isConfirmHidden = !_isConfirmHidden;
                    });
                  },
                  suffixIcon:
                      _isConfirmHidden
                          ? ImageAssets.passwordHide
                          : ImageAssets.passwordShow,
                  validator: (value) {
                    if (value != loginController.newPasswordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                  isBorder: true,
                  borderColor: ColorAssets.grey,
                ),
                SizedBox(height: Constant.size35),
                CommonButton(
                  label: "Update Changes",
                  onClick: loginController.changePassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
