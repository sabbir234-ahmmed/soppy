
import 'package:e_commerce/common/widgets/button/elevated_button.dart';
import 'package:e_commerce/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    return Positioned(
      left: 0,
      right: 0,
      bottom: USizes.spaceBtwItems,
      child: UElevatedButton(
        child: Obx ( ()=> Text(controller.currentIndex.value==2 ? "GetStarted": "Next")),
        onPressed: (){
          return controller.nextPage();
        },
      ),
    );
  }
}