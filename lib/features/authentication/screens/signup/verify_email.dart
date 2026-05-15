
import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/button/elevated_button.dart';
import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/features/authentication/controllers/signup/verify_email_controller.dart';


import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/helpers/device_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class VerifyEmailScreen extends StatelessWidget {
  final String? email;
  const  VerifyEmailScreen({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    //create controller
    final controller =Get.put(VerifyEmailController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          // for cross icon --- close button
          IconButton(
            onPressed: () {
               AuthenticationRepository.instance.logout();
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
              Text(UTexts.emailSentTitle, style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium),
              //Email
              Text(email?? "", style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium),
              //space
              SizedBox(height: USizes.spaceBtwItems),
              //SubTite
              Text(UTexts.emailSentSubTitle, style: Theme
                  .of(context).textTheme.labelMedium,textAlign: TextAlign.center),
              //space
              SizedBox(height: USizes.spaceBtwSections),

              ///---------[Footer]----------
              //continue button
              UElevatedButton(
                onPressed: () {
                  controller.checkEmailVerificationStatus();
                },
                child: Text(UTexts.uContinue),
              ),

              //resend email button
              SizedBox(
                width: UDeviceHelper.getScreenWidth(context),
                child: TextButton(
                  onPressed: () {
                    controller.sendEmailVerification();
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
