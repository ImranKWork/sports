import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/source/styles.dart';
import 'package:sports_trending/utils/screen_util.dart';
import 'package:sports_trending/widgets/common_button.dart';
import 'package:sports_trending/widgets/common_header.dart' show CommonAppBar;
import 'package:sports_trending/widgets/custom_text_form_field.dart';
import '../../help_support/controllers/help_support_controller.dart';

class PrivacyPolicyView extends GetView<HelpSupportController> {
  PrivacyPolicyView({super.key});

  final HelpSupportController helpSupportController = Get.put(
    HelpSupportController(),
  );

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
                "Privacy & Policy",
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
          horizontal: Constant.size16,
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
          "Frequently asked question",
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
          "Contact us",
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
                    "Get In Touch With Us",
                    style: Styles.textStyleBlackMedium,
                  ),
                ),
                SizedBox(height: Constant.size16),
                Text("Name", style: Styles.textStyleBlackMedium),
                SizedBox(height: Constant.size16),
                CustomTextFormField(
                  controller: helpSupportController.nameController,
                  isBorder: true,
                  disableFloatingLabel: false,
                  fillColor: Colors.transparent,

                  borderColor: ColorAssets.lightGreyVariant1,
                ),
                SizedBox(height: Constant.size24),
                Text("Email", style: Styles.textStyleBlackMedium),
                SizedBox(height: Constant.size16),
                CustomTextFormField(
                  disableFloatingLabel: false,
                  controller: helpSupportController.emailController,
                  isBorder: true,
                  fillColor: Colors.transparent,

                  borderColor: ColorAssets.lightGreyVariant1,
                ),
                SizedBox(height: Constant.size24),
                Text("Message", style: Styles.textStyleBlackMedium),
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
                    label: "Send Message",
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
