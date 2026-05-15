import 'package:e_commerce/data/repository/user/user_repository.dart';
import 'package:e_commerce/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:e_commerce/utils/popups/snackbar_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangeNameController extends GetxController{
   static ChangeNameController get instance => Get.find();

   /// variables
   final _userController=UserController.instance;
   final _userRepository=UserRepository.instance;

   final firstName=TextEditingController();
   final lastName=TextEditingController();

   final updateUserFormKey= GlobalKey<FormState>();

   @override
  void onInit() {
     super.onInit();

     initializedNames();
  }

  /// function for initialize given new name
  void initializedNames(){
    firstName.text=_userController.user.value.firstName;
    lastName.text=_userController.user.value.lastName;

  }

  /// function for update user name
   /// this method will call the authentication repo for updating name
  Future<void> updateUserName()async {
     try{
      /// start loading
       UFullScreenLoader.openLoadingDialog("We are Updating your Information");
      /// check internet connectivity
       bool isConnected= await NetworkManager.instance.isConnected();
       //if not connected
       if(!isConnected){
         //stop loading
         UFullScreenLoader.stopLoading();
         return ;
       }
       /// form validation
       if(!updateUserFormKey.currentState!.validate()){
         // stop loading
         UFullScreenLoader.stopLoading();
         return;
       }
       /// update user name from fire store
       await _userRepository.updateSingleField({"firstName":firstName.text, "lastName": lastName.text},);
       /// update user form RX user
       _userController.user.value.firstName=firstName.text;
       _userController.user.value.lastName=lastName.text;

       /// stop loading
       UFullScreenLoader.stopLoading();
       /// redirect user on navigation menu
       Get.offAll(NavigationMenu());
       ///success message
       USnackBarHelpers.successSnackBar(title:"Congratulations", message: "Your name Updated Successfully");
     }catch (e){
       // stop loading
       UFullScreenLoader.stopLoading();
       USnackBarHelpers.errorSnackBar(title:"Update Name Failed", message: e.toString());
     }
  }

}