
import 'package:e_commerce/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:e_commerce/utils/helpers/device_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingSkipButton extends StatelessWidget {
  const OnBoardingSkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller= OnBoardingController.instance;
    return Obx(
            ()=> controller.currentIndex.value==2 ? SizedBox(): Positioned(
                top: UDeviceHelper.getAppBarHeight(),
                right: 0,
                child: TextButton(onPressed: (){
                  return controller.skipPage();
                }, child: Text("Skip"))
            )
    );
  }
}