import 'package:e_commerce/common/styles/padding.dart';

import 'package:e_commerce/common/widgets/button/social_buttons.dart';
import 'package:e_commerce/common/widgets/login_signup/form_divider.dart';
import 'package:e_commerce/features/authentication/controllers/signup/signup_controller.dart';
import 'package:e_commerce/features/authentication/screens/signup/widgets/signup_form.dart';

import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //create controller of SignUpController class
    final controller=Get.put(SignUpController());

    final dark =UHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),

      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///-----[Header]--------///
              Text(
                UTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              //space
              SizedBox(height: USizes.spaceBtwSections),

              ///----[Form]-------///
              USignupForm(),
              //space
              SizedBox(height: USizes.spaceBtwSections),
              ///----[Divider]----///
              UFormDivider(dark: dark, title: UTexts.orSignupWith),
              //space
              SizedBox(height: USizes.spaceBtwSections),
              ///----[Footer]-----///
              //social
              USocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}


