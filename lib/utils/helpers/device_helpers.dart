//purpose to track the size of device appbar,navigation bar etc around whole of the project

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UDeviceHelper{
  UDeviceHelper._();

  ///for automatically hide keyboard
  static void hideKeyboard(BuildContext context){
    FocusScope.of(context).requestFocus(FocusNode());
  }

  ///setting statusbar color
  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color),
    );
  }

  ///portrait or not??  //but chatgpt suggest that that function name should be isKeyBoardOpen or not??
  static bool isPortraitOrientation(BuildContext context){
    final viewInsets=View.of(context).viewInsets;
    return viewInsets.bottom !=0;
  }


  ///set full screen
  static void setFullScreen(bool enable){
    SystemChrome.setEnabledSystemUIMode(enable ? SystemUiMode.immersiveSticky: SystemUiMode.edgeToEdge);
  }

  /// get bottomNavigationBarHeight(default flutter application's)
  static double getBottomNavigationBarHeight(){
    return kBottomNavigationBarHeight;
  }

  /// getScreenHeight(application's screen height)
  static double getScreenHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }

  ///getScreenWidth(application's)
  static double getScreenWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  /// get appBarHeight(default application's) constant
  static double getAppBarHeight(){
    return kToolbarHeight;
  }

  /// getKeyBoardHeight(application's)
  static double getKeyBoardHeight(BuildContext context){
    final viewInsets=MediaQuery.of(context).viewInsets;

    return viewInsets.bottom;
  }

}