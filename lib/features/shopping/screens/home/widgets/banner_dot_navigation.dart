import 'package:e_commerce/features/shopping/controllers/banner/banner_controller.dart';
import 'package:e_commerce/features/shopping/controllers/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// dot Navigation indicator
class  BannersDotNavigation extends StatelessWidget {
  const BannersDotNavigation({super.key});


  @override
  Widget build(BuildContext context) {
    //use controller
    final bannerController=Get.put(BannerController());

    return Obx( ()=>SmoothPageIndicator(
        count: bannerController.banners.length,
        effect: ExpandingDotsEffect(dotHeight: 6.0),

        controller: PageController(initialPage: bannerController.currentIndex.value ),
      ),
    );
  }
}