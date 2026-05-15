import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/button/elevated_button.dart';

import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/helpers/device_helpers.dart';
import 'package:flutter/material.dart';


class SuccessScreen extends StatelessWidget {
  const SuccessScreen ({super.key, required this.image, required this.title, required this.subtitle, required this.onTap});

  final String image,title,subtitle;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              ///----------[Image]---------
               SizedBox(
                width: double.infinity,
                child: Image.asset(image,
                  height: UDeviceHelper.getScreenWidth(context) * 0.6,
                  fit: BoxFit.cover,
                ),
              ),

              ///---------[Header]--------
              //Title
              Text(title, style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium,textAlign: TextAlign.center,),
              SizedBox(height: USizes.spaceBtwItems/2),
              //SubTite
              Text(subtitle, style: Theme
                  .of(context).textTheme.labelMedium,textAlign: TextAlign.center),
              //space
              SizedBox(height: USizes.spaceBtwSections),

              ///---------[Footer]----------
              //continue button
              UElevatedButton(
                onPressed: onTap,
                child: Text(UTexts.uContinue),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
