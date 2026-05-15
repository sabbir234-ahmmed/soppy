import 'package:e_commerce/common/widgets/icons/circular_icon.dart';
import 'package:e_commerce/common/widgets/images/user_profile_logo.dart';
import 'package:e_commerce/features/personalization/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserProfileWithEditIcon extends StatelessWidget {
  const UserProfileWithEditIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller= UserController.instance;
    return Stack(
        children:[
          ///user profile logo
          Center(child: UserProfileLogo()),
          ///edit icon
          Obx(
            ( ){
              if(controller.isProfileUploading.value){
                return SizedBox();
              }

              return Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(
                    child: UCircularIcon(icon: Iconsax.edit, onPressed: ()=> controller.updateUserProfilePicture(),)),
              );

            }
          ),
        ]
    );
  }
}