import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sports_trending/app/modules/login/controllers/login_controller.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/image_assets.dart';
import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../../../../widgets/common_button.dart';
import '../../../../widgets/common_header.dart';

class ChangePasswd extends StatefulWidget {
  const ChangePasswd({super.key});

  @override
  State<ChangePasswd> createState() => _ChangePasswdState();
}

class _ChangePasswdState extends State<ChangePasswd> {
  final loginController = Get.put(LoginController(), permanent: true);
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
                TextFormField(
                  controller: loginController.oldPasswordController,
                  obscureText: _isOldHidden,
                  textInputAction: TextInputAction.done,
                  style: Styles.textStyleBlackMedium,
                  decoration: InputDecoration(
                    hintText: "Enter Password",
                    hintStyle: Styles.textStyleWhite14.copyWith(fontSize: 12),
                    contentPadding: const EdgeInsets.only(right: 14, left: 8),

                    suffixIcon: IconButton(
                      icon: SvgPicture.asset(
                        _isOldHidden
                            ? ImageAssets.passwordHide
                            : ImageAssets.passwordShow,
                        height: 20,
                        width: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _isOldHidden = !_isOldHidden;
                        });
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorAssets.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(Constant.size8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                      borderRadius: BorderRadius.circular(Constant.size8),
                    ),
                  ),
                  validator:
                      (value) =>
                          value!.isEmpty ? "Please enter old password" : null,
                ),
                SizedBox(height: Constant.size20),
                Text("New Password", style: Styles.textBlackHeader),
                SizedBox(height: Constant.size15),
                TextFormField(
                  controller: loginController.newPasswordController,
                  obscureText: _isNewHidden,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: "Enter New Password",
                    hintStyle: Styles.textStyleWhite14.copyWith(fontSize: 12),

                    suffixIcon: IconButton(
                      icon: SvgPicture.asset(
                        _isNewHidden
                            ? ImageAssets.passwordHide
                            : ImageAssets.passwordShow,
                        height: 20,
                        width: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _isNewHidden = !_isNewHidden;
                        });
                      },
                    ),
                    contentPadding: const EdgeInsets.only(right: 14, left: 8),

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorAssets.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(Constant.size8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                      borderRadius: BorderRadius.circular(Constant.size8),
                    ),
                  ),
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
                ),
                SizedBox(height: Constant.size20),
                Text("Confirm New Password", style: Styles.textBlackHeader),
                SizedBox(height: Constant.size15),
                TextFormField(
                  controller: loginController.confirmPasswordController,
                  obscureText: _isConfirmHidden,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: "Confirm New Password",
                    hintStyle: Styles.textStyleWhite14.copyWith(fontSize: 12),

                    suffixIcon: IconButton(
                      icon: SvgPicture.asset(
                        _isConfirmHidden
                            ? ImageAssets.passwordHide
                            : ImageAssets.passwordShow,
                        height: 20,
                        width: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmHidden = !_isConfirmHidden;
                        });
                      },
                    ),
                    contentPadding: const EdgeInsets.only(right: 14, left: 8),

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorAssets.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(Constant.size8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                      borderRadius: BorderRadius.circular(Constant.size8),
                    ),
                  ),
                  validator: (value) {
                    if (value != loginController.newPasswordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                SizedBox(height: Constant.size35),

                Obx(
                  () =>
                      loginController.isLoading.value
                          ? Container(
                            alignment: Alignment.center,

                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                ColorAssets.themeColorOrange,
                              ),
                            ),
                          )
                          : CommonButton(
                            label: "Update Changes",
                            onClick: loginController.changePassword,
                          ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
