import 'package:e_commerce/common/widgets/button/elevated_button.dart';
import 'package:e_commerce/features/authentication/controllers/login/login_controller.dart';
import 'package:e_commerce/features/authentication/screens/forgot_password/forget_password.dart';
import 'package:e_commerce/features/authentication/screens/signup/signup.dart';
import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ULoginForm extends StatelessWidget {
  const ULoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller =LoginController.instance;
    return Form(
      key: controller.loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///email
          TextFormField(
            validator: (value)=>UValidator.validateEmail(value),
            controller: controller.email,
            decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: UTexts.email,
            ),
          ),

          ///space
          SizedBox(height: USizes.spaceBtwInputFields),

          ///password
          Obx(
             ()=>TextFormField(
              validator: (value)=> UValidator.validateEmptyText("Password", value),
              controller: controller.password,
              obscureText: controller.isPasswordVisible.value,

              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: UTexts.password,
                suffixIcon: IconButton(
                    onPressed: (){
                      controller.isPasswordVisible.toggle();
                    },
                    icon: Icon( !controller.isPasswordVisible.value? Iconsax.eye : Iconsax.eye_slash ),
                )
              ),
            ),
          ),

          ///space
          SizedBox(height: USizes.spaceBtwInputFields/2),

          ///remember me and forget password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              ///chcked box and remember me
              Row(
                children: [
                  Obx( ()=> Checkbox(value: controller.rememberMe.value,
                      onChanged:(value){
                        controller.rememberMe.toggle();
                      })
                  ),
                  Text(UTexts.rememberMe),
                ],
              ),

              ///forget password
              TextButton(
                onPressed: (){
                  Get.to(ForgetPasswordScreen());
                },
                child: Text(UTexts.forgetPassword),
              ),

            ],
          ),

           ///space
          SizedBox(height: USizes.spaceBtwSections),

          ///sign in
          UElevatedButton(
            onPressed: (){
              controller.loginWithEmailAndPassword();
            },
            child: Text(UTexts.signIn),
          ),
          //space
          SizedBox(height: USizes.spaceBtwItems/2),
          //create account
           SizedBox(
             width: double.infinity,
             child: OutlinedButton(
              onPressed: (){
                 Get.to( SignupScreen());
              },
              child: Text(UTexts.createAccount),
                     ),
           ),
        ],
      ),
    );
  }
}