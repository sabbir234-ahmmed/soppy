import 'package:e_commerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class UShadow{
  UShadow._();

  ///SearchBar Shadow
  static  List<BoxShadow> searchBarShadow= [
    BoxShadow(
      color: UColors.black.withValues(alpha:0.1 ),
      spreadRadius: 2.0,
      blurRadius: 4.0,
    ),
  ];


  /// vertical product shadow
  static List<BoxShadow> verticalProductShadow=[
    BoxShadow(
      color: UColors.darkGrey.withValues(alpha: 0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0,2),
    )
  ];

}