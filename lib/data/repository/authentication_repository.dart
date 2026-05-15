import 'package:e_commerce/data/repository/banner/banner_repository.dart';
import 'package:e_commerce/data/repository/brands/brands_repository.dart';
import 'package:e_commerce/data/repository/category/category_repository.dart';
import 'package:e_commerce/data/repository/product/product_repository.dart';
import 'package:e_commerce/data/repository/user/user_repository.dart';
import 'package:e_commerce/dummy_data.dart';
import 'package:e_commerce/features/authentication/screens/login/login.dart';
import 'package:e_commerce/features/authentication/screens/onboarding/onboarding.dart';
import 'package:e_commerce/features/authentication/screens/signup/verify_email.dart';
import 'package:e_commerce/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce/features/shopping/models/brands_model.dart';
import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:e_commerce/utils/exceptions/firebase_exceptions.dart';
import 'package:e_commerce/utils/exceptions/format_exceptions.dart';
import 'package:e_commerce/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();

  ///variables
  final localStorage = GetStorage();
  final _auth=FirebaseAuth.instance;

  // get current user through FirebaseAuth
  User? get currentUser=> _auth.currentUser;

  
  //Ctrl + o
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    /// redirect to the right screen
    screenRedirect();
    // upload bradCategory and productCategory
    // Get.put(CategoryRepository()).uploadBrandCategory(UDummyData.brandCategory);
    // Get.put(CategoryRepository()).uploadProductCategory(UDummyData.productCategory);

    // // upload and store products
    // Get.put(ProductRepository()).uploadProducts(UDummyData.products);

    // store brand on cloudinary and fire store
    // print("..................Call  UploadBrands.....................");
    // Get.put(BrandRepository().uploadBrands(UDummyData.brands));

    // store category on fire store one time
    //Get.put(CategoryRepository()).uploadCategories(UDummyData.categories);

    // print("🔥 BANNER Upload call ${DateTime.now()}");
    // //store banner on fire store (one time)
    // Get.put(BannerRepository()).uploadBanners(UDummyData.banner);

  }

  /// for redirecting user to the required screen
   void screenRedirect() async{
     final user=_auth.currentUser;
     if(user!=null){
       //check email verified or not
       if(user.emailVerified){
         ///verified user
        // land the user on navigation menu
         Get.offAll(()=> NavigationMenu());

         /// initialize user specific storage
         await GetStorage.init(user.uid);

       }else{
         /// unverified user
         Get.offAll(()=> VerifyEmailScreen(email: user.email,));
       }

     }else{
       localStorage.writeIfNull("isFirstTime", true);

       localStorage.read("isFirstTime")!=true ? Get.to(()=> LoginScreen()) : Get.to(()=> OnboardingScreen());
     }

  }

  //Authentication
  /// for register user on firebase with email and password
 Future<UserCredential> registerUser(String email, String password) async{
    try{
   UserCredential userCredential= await _auth.createUserWithEmailAndPassword(email: email, password: password);
   return userCredential;
    } on FirebaseAuthException catch(e){
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    }catch (e){
      throw "Something went wrong. Please try Again";
    }
  }

  /// login  user on firebase with email and password
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential userCredential= await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch(e){
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    }catch (e){
      throw "Something went wrong. Please try Again";
    }
  }

  /// sign in with google on firebase
  Future<UserCredential> signInWithGoogle() async {
    try {
      /// get instance of google
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      /// initialize google sign in
      await googleSignIn.initialize();


      // get user account
      final GoogleSignInAccount googleAccount = await googleSignIn.authenticate();

      // Get authentication details
      final GoogleSignInAuthentication googleAuth = await googleAccount.authentication;

      // Create credential for Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      /// Sign in with Firebase
      UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  /// for sending verification mail at user gmail  related with firebase
  Future<void> sendEmailVerification() async{
    try{
      await _auth.currentUser?.sendEmailVerification();
    }on FirebaseAuthException catch(e){
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    }catch (e){
      throw "Something went wrong. Please try Again";
    }
  }

  /// [forget password]---------------
  /// for sending reset password  mail at user gmail  related with firebase
  Future<void> sendPasswordResetEmail(String email) async{
    try{
     await  _auth.sendPasswordResetEmail(email:email);
    }on FirebaseAuthException catch(e){
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    }catch (e){
      throw "Something went wrong. Please try Again";
    }
  }

  /// [logOut ]--- logout the user
  Future<void> logout() async{
    try{
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn.instance.signOut();

      /// then redirect user to the login screen
      Get.offAll(()=> LoginScreen());
    }on FirebaseAuthException catch(e){
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    }catch (e){
      throw "Something went wrong. Please try Again";
    }
  }

  /// [deleteUser ]--- delete user account
  Future<void> deleteAccount() async{
    try{
      // delete profile from cloudinary
      String publicId=UserController.instance.user.value.publicId;
      if( publicId.isNotEmpty){
        // that means profile pic exist so delete it
        UserRepository.instance.deleteProfilePicture(publicId);
      }
      // delete from firestore
       await UserRepository.instance.removeUserRecord(currentUser!.uid);

       //delete from authentication (delete provider)
       await _auth.currentUser?.delete();
      /// then redirect user to the login screen
      Get.offAll(()=> LoginScreen());
    }on FirebaseAuthException catch(e){
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    }catch (e){
      throw "Something went wrong. Please try Again";
    }
  }

  /// re authenticate user
  Future<void>  reAuthenticateUserWithEmailAndPassword(String email, String password) async{
    try{
      AuthCredential credential= EmailAuthProvider.credential(email: email, password: password);
     await currentUser!.reauthenticateWithCredential(credential);


    }on FirebaseAuthException catch(e){
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    }catch (e){
      throw "Something went wrong. Please try Again";
    }
  }

}