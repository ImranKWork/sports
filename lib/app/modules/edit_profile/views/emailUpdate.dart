import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sports_trending/app/modules/language/controllers/language_controller.dart';
import 'package:sports_trending/app/modules/login/controllers/login_controller.dart';
import 'package:sports_trending/core/shared_preference.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/widgets/common_button.dart';
import 'package:sports_trending/widgets/custom_text_form_field.dart';

class UpdateEmailPage extends StatefulWidget {
  String email = "";

  UpdateEmailPage(this.email);

  @override
  _UpdateEmailPageState createState() => _UpdateEmailPageState();
}

class _UpdateEmailPageState extends State<UpdateEmailPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isWaitingForVerification = false;
  Timer? _emailCheckTimer;
  final LoginController loginController = Get.find();

  @override
  void dispose() {
    _emailCheckTimer?.cancel();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> sendEmailVerificationAndMonitor(String newEmail) async {
    final user = FirebaseAuth.instance.currentUser;

    // Create a temporary user with new email (not changing FirebaseAuth email yet)
    try {
      await user!.verifyBeforeUpdateEmail(newEmail); // sends verification link

      setState(() {
        _isWaitingForVerification = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "A verification email has been sent to $newEmail. Please verify to complete the update.",
          ),
        ),
      );

      // Start polling for verification
      _emailCheckTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
        await user.reload();
        if (user.emailVerified) {
          timer.cancel();
          setState(() => _isWaitingForVerification = false);

          await SharedPref.setValue(
            PrefsKey.email,
            _emailController.text.trim(),
          );

          Navigator.of(context).pop();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Your email address has been successfully updated!",
              ),
            ),
            snackBarAnimationStyle: AnimationStyle(
              duration: Duration(seconds: 1),
            ),
          );
        }
      });
    } catch (e) {
      if (e.toString().contains("Log in again before retrying this request")) {
        loginController.logout();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("For security reasons, please log in again.")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to send verification: $e")),
        );
      }
    } //requires-recent-login
  }

  void onSaveChanges() {
    if (_formKey.currentState!.validate()) {
      final newEmail = _emailController.text.trim();
      if (widget.email == newEmail) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "This is your Current Email, Please enter a different one",
            ),
          ),
        );
      } else {
        sendEmailVerificationAndMonitor(newEmail);
      }
    }
  }

  final LanguageController languageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Email")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            _isWaitingForVerification
                ? Center(child: CircularProgressIndicator())
                : Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: _emailController,
                        isBorder: true,
                        fillColor: Colors.transparent,
                        borderColor: ColorAssets.lightGreyVariant1,
                        textInputType: TextInputType.emailAddress,
                        placeHolder: "Enter email",
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return languageController.getLabel("email_empty");
                          } else if (!GetUtils.isEmail(value.trim())) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      CommonButton(
                        label: languageController.getLabel("save_changes"),
                        onClick: () {
                          onSaveChanges();
                        },
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
