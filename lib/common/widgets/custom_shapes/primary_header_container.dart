import 'package:e_commerce/common/widgets/custom_shapes/circular_container.dart';

import 'package:e_commerce/common/widgets/custom_shapes/clipper/rounded_edges_container.dart';
import 'package:e_commerce/utils/constants/colors.dart';

import 'package:e_commerce/utils/helpers/device_helpers.dart';
import 'package:flutter/material.dart';

class UPrimaryHeaderContainer extends StatelessWidget {
  const UPrimaryHeaderContainer({
    super.key, required this.child, required this.height,
  });
  // for child
  final  Widget child;
  final double height;
  @override
  Widget build(BuildContext context) {
    return URoundedEdges(
      child: Container(
        height: height, //UDeviceHelper.getScreenHeight(context)*0.4,
        color: UColors.primary,
        child: Stack(
          children: [
            //circle 1
            Positioned(
              top: -125,
              right: -150,
              child:UCircularContainer(
                height: UDeviceHelper.getScreenHeight(context)*0.4,
                width:  UDeviceHelper.getScreenHeight(context)*0.4,
                backgroundColor: UColors.white.withValues(alpha: 0.1),
              ),
            ),
            //circle 2
            Positioned(
              top: 50,
              right: -230,
              child: UCircularContainer(
                height:  UDeviceHelper.getScreenHeight(context)*0.4,
                width:  UDeviceHelper.getScreenHeight(context)*0.4,
                backgroundColor: UColors.white.withValues(alpha: 0.1),
              ),
            ),

            /// child
            child,
          ],
        ),
      ),
    );
  }
}

// for clipper
