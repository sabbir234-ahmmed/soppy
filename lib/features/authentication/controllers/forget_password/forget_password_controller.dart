import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/features/authentication/screens/forgot_password/reset_password.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:e_commerce/utils/popups/snackbar_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController{
  static ForgetPasswordController get instance => Get.find();

  ///variables
  final email =TextEditingController();
  final forgetPasswordFormKey=GlobalKey<FormState>();

  /// [ forget password]-----------
  /// send mail to reset password
  Future<void> sendPasswordResetEmail() async{
    try{
      //start loader
      UFullScreenLoader.openLoadingDialog("Processing your request");
      //check internet connectivity
      bool isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(title: "No Internet Connection");
        return ;
      }

      //check form validation
      if(!forgetPasswordFormKey.currentState!.validate()){
        UFullScreenLoader.stopLoading();
      }

      ///send email to reset password
      AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      //stop loading
      UFullScreenLoader.stopLoading();

      //success message
      USnackBarHelpers.successSnackBar(title: "Email Sent", message: "Email link sent to Request your password");

      //redirect
      Get.to(()=> ResetPasswordScreen(email: email.text.trim(),));

    }catch (e){
          UFullScreenLoader.stopLoading();
          USnackBarHelpers.errorSnackBar(title: "Failed to Forget Password", message: e.toString());
    }
  }

  /// resend password reset mail
  Future<void> resendPasswordResetEmail() async{
    try{
      //start loader
      UFullScreenLoader.openLoadingDialog("Processing your request");
      //check internet connectivity
      bool isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(title: "No Internet Connection");
        return ;
      }

      ///send email to reset password
      AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      //stop loading
      UFullScreenLoader.stopLoading();

      //success message
      USnackBarHelpers.successSnackBar(title: "Email Sent", message: "Email link sent to Request your password");


    }catch (e){
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(title: "Failed to Forget Password", message: e.toString());
    }
  }
}