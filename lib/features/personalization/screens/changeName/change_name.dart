
import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/button/elevated_button.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/personalization/controllers/change_name_controller.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeNameScreen extends StatelessWidget {
  const ChangeNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller= Get.put(ChangeNameController());

    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text("Change Name", style: Theme.of(context).textTheme.headlineMedium,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  UPadding.screenPadding,
          child: Column(
            children: [
              /// advice text
              Text("Update your name to keep your profile accurate and personalized",
                style: Theme.of(context).textTheme.bodyMedium!.apply(color:UColors.black.withValues(alpha: 0.6),),
              ),
              ///space
              SizedBox(height: USizes.spaceBtwSections,),
        
              /// form
              Form(
                key: controller.updateUserFormKey,
                child: Column(
                  children: [
                    /// First Name
                    TextFormField(
                      controller: controller.firstName,
                      validator: (value)=>UValidator.validateEmptyText("First Name", value),
                     decoration: InputDecoration(
                       prefixIcon: Icon(Iconsax.user_edit),
                       hintText: "First Name",
                       hintStyle: TextStyle(
                         color: UColors.darkerGrey.withValues(alpha: 0.5),
                         fontSize: 16,
                         fontWeight: FontWeight.w600,
                       ),
                     ),
                    ),
                    /// space
                    SizedBox(height: USizes.spaceBtwItems,),
                    /// Last Name
                    TextFormField(
                      controller: controller.lastName,
                      validator: (value)=>UValidator.validateEmptyText("Last Name", value),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.user_edit),
                        hintText: "Last Name",
                        hintStyle: TextStyle(
                          color: UColors.darkerGrey.withValues(alpha: 0.5),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    /// space
                    SizedBox(height: USizes.spaceBtwSections,),

                    /// Update button
                    UElevatedButton(
                        onPressed: (){
                        controller.updateUserName();
                        },
                        child: Text("Update"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
