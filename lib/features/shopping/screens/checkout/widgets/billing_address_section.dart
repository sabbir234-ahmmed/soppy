import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UBillingAddressSection extends StatelessWidget {
  const UBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController= Get.put(AddressController());
    addressController.getAddresses();

    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// [text]--- Billing Address
            USectionHeading(
              title: "Billing Address",
              buttonTittle: 'Change',
              onPressed: (){
                addressController.selectNewAddressBottomSheet(context);
              },
            ),

            SizedBox(height: USizes.spaceBtwItems/2,),

           Obx((){
             if(addressController.selectedAddress.value.id.isEmpty){
               return Text("Select Address");
             }

             final address=addressController.selectedAddress.value;
             return Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 /// [text] --- Customer name
                 Text(address.name, style: Theme.of(context).textTheme.titleLarge,),

                 ///icon & phone number
                 Row(
                   children: [
                     Icon(Iconsax.mobile,size: USizes.iconSm, color: UColors.darkGrey,),
                     SizedBox(width: USizes.spaceBtwItems/2,),
                     Text(address.phoneNumber),
                   ],
                 ),
                 //space
                 SizedBox(height: USizes.spaceBtwItems/2,),
                 ///icon & location
                 Row(
                   children: [
                     Icon(Icons.location_history,size: USizes.iconSm, color: UColors.darkGrey,),
                     SizedBox(width: USizes.spaceBtwItems/2,),
                     Expanded(
                         child: Text(address.toString(), softWrap: true,)
                     ),
                   ],
                 )
               ],
             );
           })

          ],
        );
      }

  }

