import 'package:e_commerce/features/authentication/screens/forgot_password/forget_password.dart';
import 'package:e_commerce/features/authentication/screens/login/login.dart';
import 'package:e_commerce/features/authentication/screens/onboarding/onboarding.dart';
import 'package:e_commerce/features/authentication/screens/signup/signup.dart';
import 'package:e_commerce/features/authentication/screens/signup/verify_email.dart';
import 'package:e_commerce/features/personalization/screens/address/address.dart';
import 'package:e_commerce/features/personalization/screens/editProfile/edit_profile.dart';
import 'package:e_commerce/features/personalization/screens/profile/profile.dart';
import 'package:e_commerce/features/shopping/screens/cart/cart.dart';
import 'package:e_commerce/features/shopping/screens/checkout/checkout.dart';
import 'package:e_commerce/features/shopping/screens/home/home.dart';
import 'package:e_commerce/features/shopping/screens/order/order.dart';
import 'package:e_commerce/features/shopping/screens/store/store.dart';
import 'package:e_commerce/features/shopping/screens/wishlist/wishlist.dart';
import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/routes/routes.dart';
import 'package:get/get.dart';

class UAppRoutes{
  static final screens=[
    GetPage(name: URoutes.home, page: ()=> NavigationMenu()),
    GetPage(name: URoutes.store, page: ()=> StoreScreen()),
    GetPage(name: URoutes.wishlist, page: () => const WishlistScreen(),),
    GetPage(name: URoutes.profile, page: () => const ProfileScreen(),),
    GetPage(name: URoutes.order, page: () => const OrderScreen(),),
    GetPage(name: URoutes.checkout, page: () => const CheckOutScreen(),),
    GetPage(name: URoutes.cart, page: () => const CartScreen(),),
    GetPage(name: URoutes.editProfile, page: () => const EditProfileScreen(),),
    GetPage(name: URoutes.userAddress, page: () => const AddressScreen(),),
    GetPage(name: URoutes.signup, page: () => const SignupScreen(),),
    GetPage(name: URoutes.verifyEmail, page: () => const VerifyEmailScreen(),),
    GetPage(name: URoutes.signIn, page: () => const LoginScreen(),),
    GetPage(name: URoutes.forgetPassword, page: () => const ForgetPasswordScreen(),),
    GetPage(name: URoutes.onBoarding, page: () => const OnboardingScreen(),),

  ];
}