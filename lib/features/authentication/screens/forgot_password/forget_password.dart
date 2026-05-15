import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/button/elevated_button.dart';
import 'package:e_commerce/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:e_commerce/features/authentication/screens/forgot_password/reset_password.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // create controller
    final controller=Get.put(ForgetPasswordController());

    return Scaffold(
      appBar: AppBar(),
      body:  SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///---------[Header]-------
              //title
              Text(UTexts.forgetPasswordTitle,style: Theme.of(context).textTheme.headlineMedium),
              //space
              SizedBox(height: USizes.spaceBtwItems/2),
              //subtitle
              Text(UTexts.forgetPasswordSubTitle,style: Theme.of(context).textTheme.labelMedium),
              //space
              SizedBox(height: USizes.spaceBtwSections*2),
              ///----------[Form]---------
              Column(
                children: [
                  // email field
                  Form(
                    key: controller.forgetPasswordFormKey,
                    child: TextFormField(
                      controller: controller.email,
                      validator: (value)=> UValidator.validateEmail(value),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.direct_right),
                        labelText: UTexts.email,
                      ),
                    ),
                  ),
                  //space
                   SizedBox(height: USizes.spaceBtwInputFields),
                  // send button
                  UElevatedButton(
                      onPressed: (){
                        controller.sendPasswordResetEmail();
                      },
                      child: Text(UTexts.submit),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
