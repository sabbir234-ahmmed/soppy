import 'dart:async';

import 'package:e_commerce/common/screens/success_screen.dart';
import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/popups/snackbar_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController{
  static VerifyEmailController get instance => Get.find();

  ///variables///
  @override
  void onInit() {
    super.onInit();
    // send verification email on user mail
    sendEmailVerification(); //user define method
    /// reload the app for real time update
    setTimerForAutoRedirect();

  }

  ///implement sendEmailVerification method
  /// responsesibility---> send email verification link to the current user
  Future<void> sendEmailVerification() async{
    try{
     // call authenticationRepository's sendEmailVerification method that will call the firebase
     await AuthenticationRepository.instance.sendEmailVerification();
     //show email sent message
      USnackBarHelpers.successSnackBar(title: "Email Sent", message: "Please check your mail box and Verify your Email");

    }catch (e){
      USnackBarHelpers.errorSnackBar(title: "Error",  message: e.toString());

    }
  }


  ///implement timer method
  void setTimerForAutoRedirect(){
    Timer.periodic(Duration(seconds: 1), (timer) async{
     await FirebaseAuth.instance.currentUser!.reload();

     final user=FirebaseAuth.instance.currentUser;
     //check this current user is verified or not
      if(user?.emailVerified ?? false){
        timer.cancel();
        // redirect current user to the success screen
        Get.off(()=> SuccessScreen(
            image: UImages.successfulPaymentIcon,
            title: UTexts.accountCreatedTitle,
            subtitle: UTexts.accountCreatedSubTitle,
            onTap: ()=> AuthenticationRepository.instance.screenRedirect(),
        ) );
      }
    });
  }

  /// manually check is current user's email is verified or not?
  Future<void> checkEmailVerificationStatus() async{
    try{
      final currentUser=FirebaseAuth.instance.currentUser;
      if(currentUser !=null && currentUser.emailVerified){
        // redirect current user to the success screen
        Get.off(()=> SuccessScreen(
          image: UImages.successfulPaymentIcon,
          title: UTexts.accountCreatedTitle,
          subtitle: UTexts.accountCreatedSubTitle,
          onTap: ()=> AuthenticationRepository.instance.screenRedirect(),
        ) );
      }
    }catch (e){
       USnackBarHelpers.errorSnackBar(title: "Error", message: e.toString());
    }
  }






}