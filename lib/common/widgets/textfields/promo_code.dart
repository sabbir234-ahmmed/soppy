import 'package:e_commerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class UPromoCodeField extends StatelessWidget {
  const UPromoCodeField({
    super.key,

  });



  @override
  Widget build(BuildContext context) {
    final bool dark = UHelperFunction.isDarkMode(context);

    return URoundedContainer(
      showBorder: true,
      padding: EdgeInsets.only(left: USizes.sm, right: USizes.sm, top: USizes.sm, bottom: USizes.sm),
      /// field ---- apply button
      child: Row(
        children: [
          // promo text field
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Have a promo code?",
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,

              ),
            ),
          ),

          // apply button
          SizedBox(
            width: 80,
            child: ElevatedButton(
              onPressed: (){

              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.withValues(alpha:0.2 ),
                  foregroundColor: dark ? UColors.white.withValues(alpha: 0.5) : UColors.dark.withValues(alpha: 0.5),
                  side: BorderSide(color: Colors.grey.withValues(alpha: 0.1))
              ),
              child: Text("Apply"),
            ),
          )

        ],
      ),
    );
  }
}