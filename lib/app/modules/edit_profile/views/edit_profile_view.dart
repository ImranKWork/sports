import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sports_trending/app/modules/edit_profile/views/emailUpdate.dart';
import 'package:sports_trending/app/modules/home/views/home_view.dart';
import 'package:sports_trending/app/modules/language/controllers/language_controller.dart';
import 'package:sports_trending/core/shared_preference.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/widgets/common_button.dart';
import 'package:sports_trending/widgets/common_header.dart' show CommonAppBar;
import 'package:sports_trending/widgets/custom_text_form_field.dart';

import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  EditProfileView({super.key});

  final EditProfileController controller = Get.put(EditProfileController());
  final LanguageController languageController = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.setEditProfileData();
    return Scaffold(
      backgroundColor: ColorAssets.white,
      resizeToAvoidBottomInset: true,
      appBar: CommonAppBar(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back, color: Colors.white),
              ),
              Text(
                languageController.getLabel("edit_profile"),
                style: Styles.textStyleWhiteBold.copyWith(
                  fontSize: FontSize.s18,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: Constant.size15,
                vertical: Constant.size30,
              ),
              children: [
                Text(
                  languageController.getLabel("name"),
                  style: Styles.textStyleBlackMedium,
                ),
                SizedBox(height: Constant.size16),
                CustomTextFormField(
                  controller: controller.nameController,
                  isBorder: true,
                  fillColor: Colors.transparent,
                  borderColor: ColorAssets.lightGreyVariant1,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Name is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: Constant.size24),
                Text(
                  languageController.getLabel("email_header"),
                  style: Styles.textStyleBlackMedium,
                ),
                SizedBox(height: Constant.size16),
                // CustomTextFormField(
                //   controller: controller.emailController,
                //   isBorder: true,
                //   isEditable: false,
                //   fillColor: Colors.transparent,
                //   borderColor: ColorAssets.lightGreyVariant1,
                //   textInputType: TextInputType.emailAddress,
                //   validator: (value) {
                //     if (value == null || value.trim().isEmpty) {
                //       return "Email is required";
                //     } else if (!GetUtils.isEmail(value.trim())) {
                //       return "Enter a valid email";
                //     }
                //     return null;
                //   },
                // ),
                TextFormField(
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  readOnly: true,
                  enabled: false, // Disables the field
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Email",
                    hintStyle: Styles.textStyleDarkGreyNormal,
                    counterText: "",
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorAssets.themeColorOrange,
                      ),
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
                    disabledBorder: OutlineInputBorder(
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
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Email is required";
                    } else if (!GetUtils.isEmail(value.trim())) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        String email = SharedPref.getString(PrefsKey.email, "");
                        if (controller.emailController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Email is required")),
                          );
                        } else if (!GetUtils.isEmail(
                          controller.emailController.text.trim(),
                        )) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Enter a valid email")),
                          );
                        } else {
                          Get.off(() => UpdateEmailPage(email));
                        }
                      },
                      child: Text(
                        languageController.getLabel("Change"),
                        style: Styles.textStyleBlackMedium,
                      ),
                    ),
                  ],
                ),

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
                    controller: controller.mobileController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    initialCountryCode: controller.countryN.value,
                    disableLengthCheck: true,
                    showDropdownIcon: true,
                    onCountryChanged: ((value) {
                      controller.countryN.value = value.code.toString();
                      controller.mobileController.text = "";
                    }),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Enter phone (Ex: XXXXXXXXXX)",
                      hintStyle: Styles.textBlackHeader,
                      counterText: "",
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorAssets.themeColorOrange,
                        ),
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
                      controller.countryCode.value = phone.countryCode;
                      controller.countryN.value =
                          phone.countryISOCode.toString();
                    },
                    validator: (phone) {
                      if (phone == null || phone.number.isEmpty) {
                        return 'Phone number is required';
                      }
                      if (phone.number.length < 10 ||
                          phone.number.length > 15) {
                        return 'Enter a valid phone number';
                      }
                      if (!RegExp(r'^\d+$').hasMatch(phone.number)) {
                        return 'Phone number should contain only digits';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: Constant.size24),
                Text(
                  languageController.getLabel("bio_header"),
                  style: Styles.textStyleBlackMedium,
                ),
                SizedBox(height: Constant.size16),
                CustomTextFormField(
                  controller: controller.bioController,
                  isBorder: true,
                  fillColor: Colors.transparent,
                  maxLines: 4,
                  borderColor: ColorAssets.lightGreyVariant1,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Constant.size15,
          vertical: Constant.size30,
        ),
        child: Obx(
          () =>
              controller.isLoading.value
                  ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        ColorAssets.themeColorOrange,
                      ),
                    ),
                  )
                  : CommonButton(
                    label: languageController.getLabel("save_changes"),
                    onClick: () {
                      controller.save();
                    },
                  ),
        ),
      ),
    );
  }
}
