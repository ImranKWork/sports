import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/widgets/common_button.dart';
import 'package:sports_trending/widgets/common_header.dart' show CommonAppBar;
import 'package:sports_trending/widgets/custom_text_form_field.dart';

import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../../language/controllers/language_controller.dart';
import '../controllers/help_support_controller.dart';

class HelpSupportView extends GetView<HelpSupportController> {
  HelpSupportView({super.key});

  final HelpSupportController helpSupportController = Get.put(
    HelpSupportController(),
  );
  final LanguageController languageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                languageController.getLabel("help_supp"),

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
                    horizontal: Constant.size10,
                    vertical: Constant.size30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Constant.size4,
                            vertical: Constant.size4,
                          ),
                          decoration: BoxDecoration(
                            color: ColorAssets.lightGrey,
                            borderRadius: BorderRadius.circular(Constant.size6),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildTabButton(
                                languageController.getLabel("privacy_policy"),

                                0,
                              ),
                              _buildTabButton(
                                languageController.getLabel("terms_conditions"),

                                1,
                              ),
                              _buildTabButton(
                                languageController.getLabel("faq"),

                                2,
                              ),
                              _buildTabButton(
                                languageController.getLabel("contact_us"),

                                3,
                              ),
                            ],
                          ),
                        ),
                      ),

                      Obx(
                        () =>
                            controller.isLoading.value
                                ? Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.symmetric(
                                    vertical: Constant.size150,
                                  ),
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      ColorAssets.themeColorOrange,
                                    ),
                                  ),
                                )
                                : Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Constant.size10,
                                  ),
                                  child:
                                      controller.selectedIndex.value == 0
                                          ? HtmlWidget(controller.content.value)
                                          : controller.selectedIndex.value == 1
                                          ? HtmlWidget(
                                            controller.termcontent.value,
                                          )
                                          : controller.selectedIndex.value == 2
                                          ? _faq()
                                          : _contactUs(),
                                ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Constant.size6,
          vertical: Constant.size10,
        ),
        decoration: BoxDecoration(
          color:
              controller.selectedIndex.value == index
                  ? ColorAssets.themeColorOrange
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(Constant.size6),
        ),
        child: Text(
          title,
          style: Styles.textStyleBlackNormal.copyWith(
            color:
                controller.selectedIndex.value == index
                    ? ColorAssets.white
                    : ColorAssets.darkGrey,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _faq() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          languageController.getLabel("frequently_asked_question"),
          style: Styles.textStyleBlackMedium.copyWith(
            fontSize: Constant.size18,
          ),
        ),

        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          itemCount: controller.faqList.length,
          itemBuilder: (context, index) {
            var faq = controller.faqList[index];
            return FAQItem(
              faq: faq,
              onTap: () => controller.toggleFAQ(index),
              isExpanded: controller.faqList[index].isExpanded,
            );
          },
        ),
      ],
    );
  }

  Widget _contactUs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          languageController.getLabel("contact_us"),
          style: Styles.textStyleBlackMedium.copyWith(
            fontSize: Constant.size18,
          ),
        ),

        const SizedBox(height: 10),
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: Constant.size16),
                Center(
                  child: Text(
                    languageController.getLabel("touch_with_us"),
                    style: Styles.textStyleBlackMedium,
                  ),
                ),
                SizedBox(height: Constant.size16),
                Text(
                  languageController.getLabel("name"),
                  style: Styles.textStyleBlackMedium,
                ),
                SizedBox(height: Constant.size16),
                CustomTextFormField(
                  controller: helpSupportController.nameController,
                  isBorder: true,
                  disableFloatingLabel: false,
                  fillColor: Colors.transparent,

                  borderColor: ColorAssets.lightGreyVariant1,
                ),
                SizedBox(height: Constant.size24),
                Text(
                  languageController.getLabel("email_header"),
                  style: Styles.textStyleBlackMedium,
                ),
                SizedBox(height: Constant.size16),
                CustomTextFormField(
                  disableFloatingLabel: false,
                  controller: helpSupportController.emailController,
                  isBorder: true,
                  fillColor: Colors.transparent,

                  borderColor: ColorAssets.lightGreyVariant1,
                ),
                SizedBox(height: Constant.size24),
                Text(
                  languageController.getLabel("message"),
                  style: Styles.textStyleBlackMedium,
                ),
                SizedBox(height: Constant.size16),
                CustomTextFormField(
                  input: TextInputAction.next,
                  isBorder: true,
                  fillColor: Colors.transparent,
                  maxLines: 5,
                  disableFloatingLabel: false,
                  borderColor: ColorAssets.lightGreyVariant1,

                  textInputType: TextInputType.text,
                  controller: helpSupportController.msgController,
                ),
                SizedBox(height: Constant.size20),

                Obx(
                  () =>
                      controller.isSendMsgLoading.value
                          ? Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                ColorAssets.themeColorOrange,
                              ),
                            ),
                          )
                          : CommonButton(
                            label: languageController.getLabel("send_message"),
                            onClick: () {
                              controller.sendMessage();
                            },
                          ),
                ),

                SizedBox(height: Constant.size10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class FAQItem extends StatelessWidget {
  final FAQModel faq;
  final VoidCallback onTap;
  final bool isExpanded;

  const FAQItem({
    Key? key,
    required this.faq,
    required this.onTap,
    required this.isExpanded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color:
                isExpanded
                    ? ColorAssets.themeColorOrange
                    : ColorAssets.darkGrey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    faq.question,
                    style: Styles.textStyleBlackRegular,
                  ),
                ),
                Icon(
                  faq.isExpanded
                      ? Icons.keyboard_arrow_right
                      : Icons.keyboard_arrow_down_sharp,
                  color:
                      isExpanded
                          ? ColorAssets.themeColorOrange
                          : ColorAssets.darkGrey,
                ),
              ],
            ),

            // Answer (conditionally visible)
            if (faq.isExpanded)
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  faq.answer,
                  style: Styles.textStyleBlackRegular.copyWith(
                    color: ColorAssets.darkGrey,
                    fontSize: FontSize.s10,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
