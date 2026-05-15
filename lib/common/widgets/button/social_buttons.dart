import 'package:e_commerce/features/authentication/controllers/login/login_controller.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class USocialButtons extends StatelessWidget {
  const USocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller= Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //google icon button
        buildButton(
            UImages.googleIcon,
                (){
                 controller.googleSignIn();
                }
        ),
        //space
        SizedBox(width: USizes.spaceBtwItems),
        //facebook icon button
        buildButton(UImages.facebookIcon, (){} ),

      ],
    );
  }

  Container buildButton(String image, VoidCallback onPressed ) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: UColors.grey),
          borderRadius: BorderRadius.circular(100),
        ),
        child: IconButton(
            onPressed: onPressed,
            icon: Image.asset(image,height: USizes.iconMd, width: USizes.iconMd,)
        ),
      );
  }
}