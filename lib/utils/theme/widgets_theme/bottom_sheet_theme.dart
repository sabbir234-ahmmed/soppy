import 'package:e_commerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class UBottomSheetTheme{
  UBottomSheetTheme._();

  //lightBottomSheetTheme
  static BottomSheetThemeData lightBottomSheetTheme=BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: UColors.white,
    modalBackgroundColor: UColors.white,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );

  //darkBottomSheetTheme
  static BottomSheetThemeData darkBottomSheetTheme=BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: UColors.black,
    modalBackgroundColor: UColors.black,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );
}