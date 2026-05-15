import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/login_signup/form_divider.dart';
import 'package:e_commerce/common/widgets/button/social_buttons.dart';
import 'package:e_commerce/features/authentication/controllers/login/login_controller.dart';
import 'package:e_commerce/features/authentication/screens/login/widgets/login_form.dart';
import 'package:e_commerce/features/authentication/screens/login/widgets/login_header.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    final dark=UHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar() ,
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ///---[Header]---///
              //Title & SubTitle
              ULoginHeader(),
        
              SizedBox(height: USizes.spaceBtwSections),
        
              ///--- [Form]----///
              ULoginForm(),
              //space
              SizedBox(height: USizes.spaceBtwItems),
              ///-----[Divider]-----///
              UFormDivider(dark: dark ,title: UTexts.orSigninWith,),
        
              //space
              SizedBox(height: USizes.spaceBtwSections),
              ///-----[Footer]------///
              ///social Buttons
              USocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}








