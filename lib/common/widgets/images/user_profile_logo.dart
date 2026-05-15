import 'package:e_commerce/common/widgets/images/circular_image.dart';
import 'package:e_commerce/common/widgets/shimmer/shimmer_effect.dart';
import 'package:e_commerce/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileLogo extends StatelessWidget {
  const UserProfileLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller= UserController.instance;

    return Obx(
        (){
          bool isProfileAvailable= controller.user.value.profilePicture.isNotEmpty;
          // if profile uploading then add shimmer effect
          if(controller.isProfileUploading.value){
            return UShimmerEffect(
                width: 120.0,
                height: 120.0,
                radius: 120.0,
            );
          }
          return UCircularImage(
            padding: 0.0,
            showBorder: true,
            borderWidth: 5.0,
            height: 120.0,
            width: 120.0,
            image: isProfileAvailable ? controller.user.value.profilePicture: UImages.profileLogo,
            isNetworkImage: isProfileAvailable? true : false,
          );
        }
    );
  }
}