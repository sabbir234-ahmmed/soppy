import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';

import 'package:flutter/material.dart';

class URoundedContainer extends StatelessWidget {
  const URoundedContainer({
    super.key,
    this.height,
    this.width,
    this.radius=USizes.cardRadiusLg,
    this.child,
    this.showBorder=false,
    this.borderColor=UColors.borderPrimary,
    this.backgroundColor = UColors.white,
    this.padding,
    this.margin,

  });

  //variables
  final double? height, width;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor, backgroundColor;
  final EdgeInsetsGeometry? padding, margin;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor): null,
      ),

      ///child widget
      child: child,
    );
  }
}
