import 'package:e_commerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class UChipTheme{
  UChipTheme._();

  //light chip theme
  static ChipThemeData lightChipTheme=ChipThemeData(
    disabledColor: UColors.grey.withValues(alpha: 0.4),
    labelStyle: const TextStyle(color: UColors.black),
    selectedColor: UColors.primary,
    checkmarkColor: UColors.white,
    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12),
  );

  //dark chip theme
  static ChipThemeData darkChipTheme=ChipThemeData(
      disabledColor: UColors.grey.withValues(alpha: 0.4),
      labelStyle: const TextStyle(color: UColors.white),
      selectedColor: UColors.primary,
      checkmarkColor: UColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12)
  );

}