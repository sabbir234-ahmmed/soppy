import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/data/repository/user/user_repository.dart';
import 'package:e_commerce/features/authentication/models/user_model.dart';
import 'package:e_commerce/features/authentication/screens/signup/verify_email.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:e_commerce/utils/popups/snackbar_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
  static SignUpController get instance=> Get.find();

  ///variables
  final signUpFormKey= GlobalKey<FormState>();

  RxBool isPasswordVisible =false.obs;
  RxBool privacyPolicy= false.obs;

  //for getting user inputted information
  final firstName= TextEditingController();
  final lastName= TextEditingController();
  final email= TextEditingController();
  final phoneNumber=TextEditingController();
  final password= TextEditingController();

  ///Function to register the user with email and password
  Future<void> registerUser() async {
    try {
      // full screen loading animation
      UFullScreenLoader.openLoadingDialog(
          "We are processing your information...");

      // check internet connectivity
      bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(title: "No Internet Connection");
        return;
      }

      //check privacy policy
      if (!privacyPolicy.value) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(title: "Please Accept Privacy Policy",
            message: " in order to create account you must have to read and accept the privacy policy & terms of use.");
        return;
      }
      // form validation
      if (!signUpFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return ;
      }
      // create user using firebase authentication
      UserCredential userCredential = await AuthenticationRepository.instance.registerUser(
          email.text.trim(), password.text.trim());

      ///create user model
      UserModel userModel = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text,
        lastName: lastName.text,
        username: '${firstName.text}${lastName.text}123',
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      /// save user record
      final userRepository = Get.put(UserRepository());

      await userRepository.saveUserRecord(userModel);



      /// show snacks bar (success snack bar)
      USnackBarHelpers.successSnackBar(title: "Congratulations!",
          message: "Your account has been created successfully");

      ///stop loading
      UFullScreenLoader.stopLoading();

      /// redirect to verify email screen
      Get.to(() => VerifyEmailScreen(email: email.text));
    }catch(e){
      ///stop loading
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(title: "Error", message: e.toString());
    }
  }
}