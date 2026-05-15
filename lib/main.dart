import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce/firebase_options.dart';
import 'package:e_commerce/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


Future<void> main() async {
  ///widgets Flutter binding
  final widgetsBinding=WidgetsFlutterBinding.ensureInitialized();

  ///flutter native splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// get_storage initialization
  await GetStorage.init();

  /// Firebase Initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value){
    Get.put(AuthenticationRepository());
    //Get.put(UserController());
  });


  /// for ensure only portrait representation of our apps
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}






