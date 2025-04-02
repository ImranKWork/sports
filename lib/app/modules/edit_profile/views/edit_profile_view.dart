import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_trending/app/modules/language/controllers/language_controller.dart';
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
              shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Constant.size15,
                    vertical: Constant.size30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text( languageController.getLabel("name"), style: Styles.textStyleBlackMedium),
                      SizedBox(height: Constant.size16),
                      CustomTextFormField(
                        controller: controller.nameController,
                        isBorder: true,
                        fillColor: Colors.transparent,
                        borderColor: ColorAssets.lightGreyVariant1,
                      ),
                      SizedBox(height: Constant.size24),
                      Text(languageController.getLabel("email_header"), style: Styles.textStyleBlackMedium),
                      SizedBox(height: Constant.size16),
                      CustomTextFormField(
                        controller: controller.emailController,
                        isBorder: true,
                        fillColor: Colors.transparent,
                        borderColor: ColorAssets.lightGreyVariant1,
                      ),
                      SizedBox(height: Constant.size24),
                      Text(languageController.getLabel("phone_header"), style: Styles.textStyleBlackMedium),
                      SizedBox(height: Constant.size16),
                      CustomTextFormField(
                        input: TextInputAction.next,
                        isBorder: true,
                        fillColor: Colors.transparent,
                        placeHolder:
                        "${languageController.getLabel("phone_empty")} (Ex: +1 XXXXXXXXXX)",
                        borderColor: ColorAssets.lightGreyVariant1,
                        textInputType: TextInputType.phone,

                        controller: controller.mobileController,
                        disableFloatingLabel: true,
                      ),
                      SizedBox(height: Constant.size24),
                      Text(languageController.getLabel("bio_header"), style: Styles.textStyleBlackMedium),
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
