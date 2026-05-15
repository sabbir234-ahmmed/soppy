import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class UCheckboxTheme{
  UCheckboxTheme._();

  //lightCheckboxTheme
  static CheckboxThemeData lightCheckboxTheme=CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(USizes.xs)),
    checkColor: WidgetStateProperty.resolveWith((states){
     if(states.contains(WidgetState.selected)){
       return UColors.white;
     }else{
       return UColors.black;
     }
    }),

    fillColor: WidgetStateProperty.resolveWith((states){
      if(states.contains(WidgetState.selected)){
        return UColors.primary;
      }else{
        return Colors.transparent;
      }
    }),

  );

  //darkCheckboxTheme
   static CheckboxThemeData darkCheckboxTheme= CheckboxThemeData(
     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(USizes.xs)),
     checkColor: WidgetStateProperty.resolveWith((states){
       if(states.contains(WidgetState.selected)){
         return UColors.white;
       }else{
         return UColors.black;
       }
     }),

     fillColor: WidgetStateProperty.resolveWith((states){
       if(states.contains(WidgetState.selected)){
         return UColors.primary;
       }else{
         return Colors.transparent;
       }
     }),
   );

}