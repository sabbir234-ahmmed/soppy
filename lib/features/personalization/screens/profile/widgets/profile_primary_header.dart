import 'package:e_commerce/common/widgets/custom_shapes/primary_header_container.dart';

import 'package:e_commerce/common/widgets/images/user_profile_logo.dart';

import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class UProfilePrimaryHeader extends StatelessWidget {
  const UProfilePrimaryHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ///total header surface height
        //sized boxed with header size + displacement to hold half of rounded image
        SizedBox(height: USizes.profilePrimaryHeaderHeight + 60),

        ///UPrimary Header container
        UPrimaryHeaderContainer(
          height: USizes.profilePrimaryHeaderHeight,
          child: Container(),
        ),

        ///circular profile image
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: UserProfileLogo(),
          ),
        ),

      ],
    );
  }
}

