import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/button/elevated_button.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/helpers/device_helpers.dart';
import 'package:flutter/material.dart';

class AccountCreateSuccessfulyScreen extends StatelessWidget {
  const AccountCreateSuccessfulyScreen ({super.key});

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
                child: Image.asset(UImages.accountCreatedImage,
                  height: UDeviceHelper.getScreenWidth(context) * 0.6,
                  fit: BoxFit.cover,
                ),
              ),

              ///---------[Header]--------
              //Title
              Text(UTexts.accountCreatedTitle, style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium,textAlign: TextAlign.center,),
              SizedBox(height: USizes.spaceBtwItems/2),
              //SubTite
              Text(UTexts.accountCreatedSubTitle, style: Theme
                  .of(context).textTheme.labelMedium,textAlign: TextAlign.center),
              //space
              SizedBox(height: USizes.spaceBtwSections),

              ///---------[Footer]----------
              //Done button
              UElevatedButton(
                onPressed: () {

                },
                child: Text(UTexts.uContinue),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
