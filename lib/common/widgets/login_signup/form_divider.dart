import 'package:e_commerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class UFormDivider extends StatelessWidget {
  const UFormDivider({
    super.key,
    required this.dark, required this.title,
  });

  final bool dark;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(indent: 60, endIndent: 5, thickness: 0.5, color: dark? UColors.darkGrey: UColors.grey)),
        Text(title,style: Theme.of(context).textTheme.labelMedium,),
        Expanded(child: Divider(indent: 5,endIndent: 55, thickness: 0.5, color: dark? UColors.darkGrey: UColors.grey)),
      ],
    );
  }
}