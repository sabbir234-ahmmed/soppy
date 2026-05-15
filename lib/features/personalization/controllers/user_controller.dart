import 'dart:io';

import 'package:e_commerce/common/widgets/button/elevated_button.dart';
import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/data/repository/user/user_repository.dart';
import 'package:e_commerce/features/authentication/models/user_model.dart';
import 'package:e_commerce/features/authentication/screens/login/login.dart';
import 'package:e_commerce/features/personalization/screens/editProfile/widgets/re_authenticate_user_form.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:e_commerce/utils/popups/snackbar_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;

class UserController extends GetxController{
  static UserController get instance => Get.find();

  /// variables
  final _userRepository= Get.put(UserRepository());
  Rx<UserModel> user= UserModel.empty().obs;
  RxBool isProfileUploading= false.obs;

  /// variable for showing loading when fetching name
  RxBool profileLoading= false.obs;

  /// re-authenticate form variables
  final email=TextEditingController();
  final password=TextEditingController();

  final reAuthFormKey=GlobalKey<FormState>();
  RxBool isPasswordVisible =false.obs;



  /// for calling fetchUserDetails function
  @override
  onInit(){
    super.onInit();
    fetchUserDetails();
  }
  /// method for save user record
  Future<void> saveUserRecord(UserCredential userCredential) async{
    try{
      ///first update rx variables and then check if user date is already stored if not then store
      await fetchUserDetails();

      if(user.value.id.isEmpty){
        /// convert full name to first name and last name
        final nameParts=UserModel.nameParts(userCredential.user!.displayName);
        final username= "${userCredential.user!.displayName}1234";

        /// create user model
        UserModel userModel= UserModel(
          id: userCredential.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length>1 ? nameParts.sublist(1).join(" "): "",
          username: username ,
          email: userCredential.user!.email ?? "",
          phoneNumber: userCredential.user!.phoneNumber ?? "",
          profilePicture: userCredential.user!.photoURL ?? "",
        );

        /// save user record
        await _userRepository.saveUserRecord(userModel);

      }

    }catch (e){
      USnackBarHelpers.errorSnackBar(title: "Data not saved", message: "Something went wrong while saving your information.");
    }
  }

  /// function for fetch user details
  Future<void> fetchUserDetails() async{
    try{
      profileLoading.value=true;
    final UserModel user= await _userRepository.fetchUserDetails();
    this.user.value=user;
    }catch (e){
    user.value=UserModel.empty();
    }finally{
      profileLoading.value=false;
    }
  }

  // function for show warning popup for confirmation delete account
  void deleteAccountWarningPopup(){
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(USizes.md),
      title: "Delete Account",
      middleText: "Are you sure you want to delete account permanently?",

      confirm: ElevatedButton(
        onPressed: ()=>deleteUserAccount(),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            side: BorderSide(
              color: Colors.red,
            )
        ),
        child: Text("Delete",),
      ),

      cancel:  OutlinedButton(
        onPressed: ()=> Get.back(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: USizes.lg),
          child: Text("Cancel"),
        ),
      ),
    );
  }

  // function for invoke delete user account
  Future<void>  deleteUserAccount() async{
    try{
      // start loading
      UFullScreenLoader.openLoadingDialog("Processing...");

      /// check provider Re-Authentication
      final authRepository=AuthenticationRepository.instance;
      final provider=authRepository.currentUser!.providerData.map((e)=> e.providerId).first;

      //if google provider ?
      if(provider=="google.com"){
        // log in with provider and delete
        await authRepository.signInWithGoogle();
        authRepository.deleteAccount();
        //stop loader
        UFullScreenLoader.stopLoading();
        // redirect user
        Get.offAll(()=> LoginScreen());

        // if email/password provider
      }else if(provider=="password"){
       // stop loader
        UFullScreenLoader.stopLoading();
        // and move to the new screen for re authentication and delete
        Get.to(()=> ReAuthenticateUserForm());
      }
    }catch (e){
      // stop loading
      UFullScreenLoader.stopLoading();
     //Show error snackbar
      USnackBarHelpers.errorSnackBar(title: "Error", message: e.toString());
    } 
  }


// re_authenticate user with email and password
Future<void> reAuthenticateUser() async{
    try{
      // start loading dialog
      UFullScreenLoader.openLoadingDialog("Processing...");

      // check internet connectivity
      bool isConnected= await NetworkManager.instance.isConnected();
      if(!isConnected){
        // close loading dialog and return
        UFullScreenLoader.stopLoading();
        return;
      }

      // form validation
      if(!reAuthFormKey.currentState!.validate()){
        //stop loading
        USnackBarHelpers.errorSnackBar(title: "Inside Form Validation");
        UFullScreenLoader.stopLoading();
        return ;
      }

      /// re-authenticate user with email and password
      await AuthenticationRepository.instance.reAuthenticateUserWithEmailAndPassword(email.text.trim(), password.text.trim());

      ///delete account
      await AuthenticationRepository.instance.deleteAccount();
      //stop loader
      UFullScreenLoader.stopLoading();
      //re direct user on login screen
      Get.offAll(()=> LoginScreen());

    }catch (e){
      // stop loading
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(title: "Failed", message: e.toString());
    }
}

/// method for update user profile pic related with cloudinary
Future<void> updateUserProfilePicture() async{
    try{
      // start loading
      isProfileUploading.value=true;

     // pick image from gallery
      XFile? image= await ImagePicker().pickImage(source: ImageSource.gallery, maxHeight: 512, maxWidth: 512);

      // if image null then return
      if(image==null){
        return ;
      }

      // convert XFile to file
      File file= File(image.path);

      /// Delete user current profile picture
      //user has profile or not?
      if(user.value.publicId.isNotEmpty){
        // has profile picture so, we can delete it first
        await _userRepository.deleteProfilePicture(user.value.publicId);
      }

      // Upload profile picture on cloudinary
      dio.Response response= await _userRepository.uploadImage(file);
      /// check response
      if(response.statusCode==200){
         // get data
         final data= response.data;
         // get a single field of data
         final imageUrl=data['secure_url'];
         // get a single field of data
         final publicId=data['public_id'];
         
         // update taken imageUrl and publicId on fire store database
         await _userRepository.updateSingleField({'profilePicture':imageUrl, 'publicId': publicId});

         // now update on user record or Rx user
         user.value.profilePicture=imageUrl;
         user.value.publicId=publicId;
         user.refresh();
         
         ///show success message 
          USnackBarHelpers.successSnackBar(title: "Congratulations", message: "Profile picture updated successfully");
         
      }else{
        throw 'Failed to upload profile picture. Please try again';
      }
    }catch (e){
      USnackBarHelpers.errorSnackBar(title:'Failed!', message: e.toString() );
    }finally{
      isProfileUploading.value=false;
    }
}
}