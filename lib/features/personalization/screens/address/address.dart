import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce/features/personalization/models/address_model.dart';

import 'package:e_commerce/features/personalization/screens/address/add_new_address.dart';
import 'package:e_commerce/features/personalization/screens/address/widgets/single_address.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// address controller
    final addressController= Get.put(AddressController());

    return Scaffold(
      ///------- app bar--------
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          "Addresses",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),

      ///------ body ----------
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,

          child: Column(
            children: [
               Obx(
                 ( )=> FutureBuilder(
                     key: Key(addressController.refreshData.value.toString()),
                     future: addressController.getAddresses(),

                     builder: (context, snapshot) {
                       /// handle future builder state, empty data, error
                      // const loader= UAddressCardShimmer();
                       const loader=CircularProgressIndicator();
                       final widget=UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                       if(widget!=null){
                         return widget;
                       }
                       List<AddressModel> addresses=snapshot.data!;
                       return ListView.separated(
                           shrinkWrap: true,
                           physics: NeverScrollableScrollPhysics(),
                           itemBuilder: (context,index){
                             print("------Under Future Builder------ CurrentAddress ID: ${addresses[index].id}--------------");
                             return USingleAddress(
                                 address: addresses[index],
                                 onTap:()=> addressController.selectAddress(addresses[index]),
                             );
                           },
                           separatorBuilder: (context,index){
                             return SizedBox(height: USizes.spaceBtwItems,);
                           },
                           itemCount:addresses.length,
                       );
                     }
                   ),
               ),

            ],
          ),
        ),
      ),

      ///floating action button
      floatingActionButton: FloatingActionButton(
        backgroundColor: UColors.primary.withValues(alpha: 0.8),
        onPressed: () {
          Get.to(AddNewAddressScreen());
        },
        child: Icon(Iconsax.add, color: UColors.white),
      ),
    );
  }
}
