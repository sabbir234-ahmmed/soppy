import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class UElevatedButtonTheme{
  UElevatedButtonTheme._();

  //lightElevatedButtonTheme
   static final lightElevatedButtonTheme= ElevatedButtonThemeData(
     style: ElevatedButton.styleFrom(
       elevation: 0,
       foregroundColor: UColors.light,
       backgroundColor: UColors.primary,
       disabledForegroundColor: UColors.grey,
       disabledBackgroundColor: UColors.buttonDisabled,
       side: const BorderSide(color:UColors.light),
       padding: const EdgeInsets.symmetric(vertical: USizes.buttonHeight),
       textStyle: const TextStyle(fontSize: 16, color:UColors.textWhite, fontWeight:FontWeight.bold),
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(USizes.buttonRadius)),
     )
   );

   //darkElevatedButtonThemeData
   static final darkElevatedButtonTheme=ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
  elevation: 0,
  foregroundColor: UColors.light,
  backgroundColor: UColors.primary,
  disabledForegroundColor: UColors.darkGrey,
  disabledBackgroundColor: UColors.darkerGrey,
  side: const BorderSide(color:UColors.primary),
  padding: const EdgeInsets.symmetric(vertical: USizes.buttonHeight),
  textStyle: const TextStyle(fontSize: 16, color:UColors.textWhite, fontWeight:FontWeight.bold),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(USizes.buttonRadius)),
   )
   );
}