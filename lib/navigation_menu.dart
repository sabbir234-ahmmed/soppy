import 'package:e_commerce/features/personalization/screens/profile/profile.dart';
import 'package:e_commerce/features/shopping/screens/home/home.dart';
import 'package:e_commerce/features/shopping/screens/store/store.dart';
import 'package:e_commerce/features/shopping/screens/wishlist/wishlist.dart';
import 'package:e_commerce/utils/constants/colors.dart';

import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    //for using Getx controller
    final controller = Get.put(NavigationController());
    //check dark mode or not
    bool dark =UHelperFunction.isDarkMode(context);
    return Scaffold(
      body: Obx( ()=> controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
            () => NavigationBar(
          elevation: 0,
          backgroundColor: dark? UColors.dark: UColors.light,
          indicatorColor: dark? UColors.white.withValues(alpha: 0.1): UColors.black.withValues(alpha: 0.1),
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) {
            controller.selectedIndex.value = index;
          },
          destinations: [
            // home destination
            NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
            // store destination
            NavigationDestination(icon: Icon(Iconsax.shop), label: "Store"),
            //
            NavigationDestination(icon: Icon(Iconsax.heart), label: "Wishlist"),
            //
            NavigationDestination(icon: Icon(Iconsax.user), label: "Profile"),
          ],
        ),
      ),
    );
  }
}

//navigation controller class
class NavigationController extends GetxController {
  RxInt selectedIndex = 0.obs;
  static NavigationController get instance=> Get.find();

  List<Widget> screens=[HomeScreen(), StoreScreen(), WishlistScreen(), ProfileScreen() ];
}
