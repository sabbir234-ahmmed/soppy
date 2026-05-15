import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/button/elevated_button.dart';
import 'package:e_commerce/features/authentication/controllers/forget_password/forget_password_controller.dart';

import 'package:e_commerce/features/authentication/screens/login/login.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/helpers/device_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});
  ///variable
  final String email;
  @override
  Widget build(BuildContext context) {
    final controller =ForgetPasswordController.instance;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          // for cross icon
          IconButton(
            onPressed: () {
              Get.offAll(LoginScreen());
            },
            icon: Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(

            children: [

              ///----------[Image]---------
               SizedBox(
                width: double.infinity,
                child: Image.asset(UImages.mailSentImage,
                    height: UDeviceHelper.getScreenWidth(context) * 0.6,
                    fit: BoxFit.cover,
                ),
              ),

              ///---------[Header]--------
              //Title
              Text(UTexts.resetPasswordTitle, style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium),
              //Email
              Text(email, style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium),
              //space
              SizedBox(height: USizes.spaceBtwItems),
              //SubTite
              Text(UTexts.resetPasswordSubTitle, style: Theme
                  .of(context).textTheme.labelMedium,textAlign: TextAlign.center),
              //space
              SizedBox(height: USizes.spaceBtwSections),

              ///---------[Footer]----------
              //Done button
              UElevatedButton(
                onPressed: () {
                 Get.offAll(LoginScreen());
                },
                child: Text(UTexts.done),
              ),

              //resend email button
              SizedBox(
                width: UDeviceHelper.getScreenWidth(context),
                child: TextButton(
                  onPressed: () {
                    controller.resendPasswordResetEmail();
                  },
                  child: Text(UTexts.resendEmail),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
