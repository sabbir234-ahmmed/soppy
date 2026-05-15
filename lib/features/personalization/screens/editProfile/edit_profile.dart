import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/appbar/appbar.dart';

import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce/features/personalization/screens/changeName/change_name.dart';
import 'package:e_commerce/features/personalization/screens/editProfile/widgets/user_details_row.dart';
import 'package:e_commerce/features/personalization/screens/editProfile/widgets/user_profile_with_edit_icon.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller= UserController.instance;
    return  Scaffold(
       /// arrow and EditProfile text
       appBar: UAppBar(
         showBackArrow: true,
         title: Text(
           "Edit Profile",
           style: Theme.of(context).textTheme.headlineMedium,
         ),

       ),

      ///body part , profile logo and some texts
      body: SingleChildScrollView(

        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              ///user profile logo with edit icon
              UserProfileWithEditIcon(),
              SizedBox(height: USizes.spaceBtwSections,),
              ///divider
              Divider(),
              SizedBox(height: USizes.spaceBtwSections,),

              /// Account Settings heading
              USectionHeading(title:"Account Settings", showButton: false,),
              SizedBox(height: USizes.spaceBtwItems,),
              ///user details row
              UserDetailsRow(title: 'Name', value: controller.user.value.fullName, onTap: (){Get.to(ChangeNameScreen());},),
              UserDetailsRow(title: 'UserName', value: controller.user.value.username,onTap: (){}),

              SizedBox(height: USizes.spaceBtwItems,),
              Divider(),
              SizedBox(height: USizes.spaceBtwItems,),

              ///profile settings heading
              USectionHeading(title:"Profile Settings", showButton: false,),
              SizedBox(height: USizes.spaceBtwItems,),
              ///user details row
              UserDetailsRow(title: 'User ID', value: controller.user.value.id, onTap: (){},),
              UserDetailsRow(title: 'Email', value: controller.user.value.email,onTap: (){}),
              UserDetailsRow(title: 'Phone', value: controller.user.value.phoneNumber, onTap: (){},),
              UserDetailsRow(title: 'Gender', value: "Male", onTap: (){},),

              SizedBox(height: USizes.spaceBtwItems),
              Divider(),
              SizedBox(height:USizes.spaceBtwItems),

              ///close account Button
              TextButton(
                  onPressed: (){
                    controller.deleteAccountWarningPopup();
                  },
                  child: Text("Close Account",style: TextStyle(color: Colors.red),),
              )
            ],
          ),
        ),
      ),
    );
  }
}




