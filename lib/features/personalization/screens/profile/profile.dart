
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/features/personalization/screens/address/address.dart';
import 'package:e_commerce/features/shopping/screens/cart/cart.dart';
import 'package:e_commerce/features/shopping/screens/order/order.dart';

import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'widgets/profile_primary_header.dart';
import 'widgets/settings_menu_tile.dart';
import 'widgets/user_profile_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// profile primary Header + circular image
            UProfilePrimaryHeader(),
        
            Padding(
                padding: EdgeInsets.all(USizes.defaultSpace),
                
                  child: Column(
                    children: [
                      /// name,email----- edit icon
                      UserProfileTile(),
                      SizedBox(height: USizes.spaceBtwItems,),
                      /// Account Settings section heading
                      USectionHeading(title: "Account Setting", showButton: false,),
                      /// settings menu
                      SettingsMenuTile(
                        icon: Iconsax.home,
                        title: "My Addresses",
                        subTitle: "Set Shopping Delivery Addresses",
                        onTap: ()=> Get.to(()=>AddressScreen()) ,
                      ),

                      SettingsMenuTile(
                        icon: Iconsax.shopping_cart,
                        title: "My Cart",
                        subTitle: "Add, Remove Product and Move to CheckOut",
                        onTap: (){
                          Get.to(CartScreen());
                        },
                      ),

                      SettingsMenuTile(
                        icon: Iconsax.bag_tick,
                        title: "My Orders",
                        subTitle: "In-Progress and Completed Orders",
                        onTap: (){
                          Get.to(OrderScreen());
                        },
                      ),

                      SizedBox(height: USizes.spaceBtwSections,),
                      ///log out button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                            onPressed: (){
                             AuthenticationRepository.instance.logout();
                            },
                            child: Text("LogOut"),
                        ),
                      ),
                      SizedBox(height: USizes.spaceBtwSections,),
                    ],
                )
              ,
            )
          ],
        ),
      ),
    );
  }
}






