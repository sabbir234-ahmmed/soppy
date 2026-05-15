import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class UTextFormFieldTheme{
  UTextFormFieldTheme._();

  //lightInputDecorationTheme
  static InputDecorationTheme lightInputDecorationTheme=InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: UColors.darkGrey,
    suffixIconColor: UColors.darkGrey ,
    //constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: USizes.fontSizeMd, color: UColors.black),
    hintStyle: const TextStyle().copyWith(fontSize: USizes.fontnSizeSm,color:UColors.black),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(color: UColors.black.withValues(alpha:10)),

    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(USizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: UColors.grey),
    ),

    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(USizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: UColors.grey),
    ),

    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(USizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: UColors.dark),
    ),

    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(USizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: UColors.warning),
    ),

    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(USizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: UColors.warning),
    ),

  );

  //darkInputDecorationTheme
  static InputDecorationTheme darkInputDecorationTheme=InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: UColors.darkGrey,
    suffixIconColor: UColors.darkGrey ,
    //constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: USizes.fontSizeMd, color: UColors.white),
    hintStyle: const TextStyle().copyWith(fontSize: USizes.fontnSizeSm,color:UColors.white),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(color: UColors.black.withValues(alpha:10)),

    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(USizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: UColors.darkGrey),
    ),

    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(USizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: UColors.darkGrey),
    ),

    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(USizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: UColors.white),
    ),

    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(USizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: UColors.warning),
    ),

    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(USizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: UColors.warning),
    ),
  );
}