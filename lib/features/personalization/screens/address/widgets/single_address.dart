import 'package:e_commerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:e_commerce/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce/features/personalization/models/address_model.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class USingleAddress extends StatelessWidget {
  const USingleAddress({
    super.key,   required this.address, required this.onTap,
  });

  ///variables for further customizing
  final AddressModel address;
  final VoidCallback onTap;



  @override
  Widget build(BuildContext context) {
    bool dark= UHelperFunction.isDarkMode(context);
    final addressController= AddressController.instance;

    return Obx(
      ( ) {
        String selectedAddressId=addressController.selectedAddress.value.id;
        bool isSelected=(selectedAddressId==address.id);

        return InkWell(
          onTap: onTap,
          child: URoundedContainer(
          backgroundColor: isSelected ? UColors.primary.withValues(alpha: 0.5): Colors.transparent ,
          borderColor: isSelected? Colors.transparent: (dark ? UColors.darkGrey : UColors.primary),
          width: double.infinity,
          showBorder: true,
          padding: EdgeInsets.all(USizes.md),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///user name
                  Text(address.name, style: Theme.of(context).textTheme.titleLarge,maxLines: 1, overflow: TextOverflow.ellipsis,),
                  ///user phone
                  Text(address.phoneNumber,maxLines: 1, overflow: TextOverflow.ellipsis,),
                  ///user address
                  Text( address.toString()),
                ],
              ),
              if(isSelected) Positioned(
                  right: 0,
                  top: 2,
                  child: Center(child: Icon(Iconsax.tick_circle)),
              ),

            ],
          ),
                ),
        );

    },
    );
  }
}