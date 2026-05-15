



import 'package:e_commerce/utils/helpers/device_helpers.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key, required this.animation, required this.title, required this.subTitle,
  });

  final String animation;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only( top: UDeviceHelper.getAppBarHeight()),
      child: Column(
        children: [
          ///animation
          Lottie.asset(animation),

          ///title
          Text(title, style: Theme.of(context).textTheme.headlineMedium,),

          ///subtitle
          Text(subTitle, textAlign: TextAlign.center),

        ],
      ),
    );
  }
}