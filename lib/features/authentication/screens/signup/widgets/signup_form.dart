import 'package:e_commerce/common/widgets/button/elevated_button.dart';
import 'package:e_commerce/features/authentication/controllers/signup/signup_controller.dart';


import 'package:e_commerce/features/authentication/screens/signup/widgets/privacy_policy_checkbox.dart';

import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

class USignupForm extends StatelessWidget {
  const USignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    //create controller of SignUpController class
    final controller = SignUpController.instance;

    return Form(
      key: controller.signUpFormKey,
      child: Column(
        children: [
          /// first name and last name field
          Row(
            children: [
              //first name field
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      UValidator.validateEmptyText("First Name", value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: UTexts.firstName,
                  ),
                ),
              ),
              //space
              SizedBox(width: USizes.spaceBtwInputFields),
              //last name field
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      UValidator.validateEmptyText("Last Name", value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: UTexts.lastName,
                  ),
                ),
              ),
            ],
          ),
          //space
          SizedBox(height: USizes.spaceBtwInputFields),

          ///email field
          TextFormField(
            controller: controller.email,
            validator: (value) => UValidator.validateEmail(value),
            decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: UTexts.email,
            ),
          ),
          //space
          SizedBox(height: USizes.spaceBtwInputFields),

          ///phone number field
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              } else if (value.length != 11) {
                return 'Phone number must be 11 digits';
              }
              return null;
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: UTexts.phoneNumber,
            ),
          ),
          //space
          SizedBox(height: USizes.spaceBtwInputFields),

          ///password field
          Obx(()=> TextFormField(
              obscureText: !controller.isPasswordVisible.value,
              controller: controller.password,
              validator: (value) => UValidator.validatePassword(value),
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: UTexts.password,
                suffixIcon: IconButton(
                    onPressed:  (){
                      controller.isPasswordVisible.value= !controller.isPasswordVisible.value;
                      
                    },
                    icon: Icon(controller.isPasswordVisible.value? Iconsax.eye : Iconsax.eye_slash),
                )
              ),
            ),
          ),
          //space
          SizedBox(height: USizes.spaceBtwInputFields / 2),

          /// privacy policy check box and text
          UPrivacyPolicyCheckbox(),

          ///create account button
          UElevatedButton(
            onPressed: (){
              controller.registerUser();
            },
            child: Text(UTexts.createAccount),
          ),
        ],
      ),
    );
  }
}
