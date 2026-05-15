
import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/button/elevated_button.dart';
import 'package:e_commerce/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthenticateUserForm extends StatelessWidget {
  const ReAuthenticateUserForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller= UserController.instance;
    return Scaffold(
      ///[App bar]-----------
      appBar: UAppBar(
        showBackArrow: true,
        title: Text("Re-Authenticate User"),
      ),

      /// [Body]----------------
      body: SingleChildScrollView(
        child: Padding(
            padding: UPadding.screenPadding,
          child: Form(
              key: controller.reAuthFormKey ,
              child: Column(
                children: [
                  /// email field
                  TextFormField(
                    controller: controller.email ,
                    validator: (value)=>UValidator.validateEmail(value),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.direct_right),
                      labelText: UTexts.email,
                    ),
                  ),

                  /// space
                  SizedBox(height: USizes.spaceBtwItems,),

                  ///password field
                  Obx( ()=>TextFormField(
                      obscureText: controller.isPasswordVisible.value,
                      controller: controller.password,
                      validator: (value)=>UValidator.validateEmptyText("password",value),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.password_check),
                        labelText: UTexts.password,
                        suffixIcon: IconButton(onPressed: (){
                         controller.isPasswordVisible.toggle();
                        }, icon: Icon( !controller.isPasswordVisible.value? Iconsax.eye : Iconsax.eye_slash),
                        ),
                      ),
                    ),
                  ),


                  /// space
                  SizedBox(height: USizes.spaceBtwSections,),

                  /// Verify Button
                  UElevatedButton(
                      onPressed: (){
                      controller.reAuthenticateUser();
                      },
                      child: Text("Verify"),
                  ),
                ],
              )
          ),
        ),
      ),

    );
  }
}
