
import 'package:e_commerce/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:e_commerce/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:e_commerce/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:e_commerce/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:e_commerce/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class OnboardingScreen extends StatelessWidget {
     const OnboardingScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: USizes.defaultSpace ),
        child: Stack(
          children: [
            PageView(
              controller: controller.pageController ,
              onPageChanged: controller.updatePageIndicator,
              children: [
                ///welcome animation start
                OnBoardingPage(
                  animation: UImages.onboarding1Animation,
                  title: UTexts.onBoardingTitle1,
                  subTitle: UTexts.onBoardingSubTitle1,
                ),

                ///welcome animation end

                ///cart animation start
                OnBoardingPage(
                  animation: UImages.onboarding2Animation,
                  title: UTexts.onBoardingTitle2,
                  subTitle: UTexts.onBoardingSubTitle2,
                ),

                ///cart animation end

                ///delivary animation start
                OnBoardingPage(
                  animation: UImages.onboarding3Animation,
                  title: UTexts.onBoardingTitle3,
                  subTitle: UTexts.onBoardingSubTitle3,
                ),

                ///delivary animation end
              ],
            ),

            ///indicator
            OnBoardingDotNavigation(),

            ///Bottom button (next)
            OnboardingNextButton(),

            ///top right skip button
            OnBoardingSkipButton(),
          ],
        ),
      ),
    );
  }
}








