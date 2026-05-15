
import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/button/elevated_button.dart';
import 'package:e_commerce/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {

     final addressController=Get.put(AddressController());

    return Scaffold(
         ///------ appbar-----
         appBar: UAppBar(
           showBackArrow: true,
           title: Text("Add New Address", style: Theme.of(context).textTheme.headlineMedium,),
         ),
      
         ///---- body-----
         body: SingleChildScrollView(
           child: Padding(
               padding: UPadding.screenPadding,
               child: Form(
                 key: addressController.addressFormKey,
                 child: Column(
                 children: [
                   ///-----[Fields]------

                   //Name
                   TextFormField(
                     controller: addressController.name,
                     validator: (value)=>UValidator.validateEmptyText('name', value),
                     decoration:InputDecoration(
                       prefixIcon: Icon(Iconsax.user),
                       labelText: "Name",
                     ),
                   ),
                   ///space
                   SizedBox(height: USizes.spaceBtwItems,),

                   //Phone Number
                   TextFormField(
                     controller: addressController.phone,
                     validator: (value)=>UValidator.validateEmptyText('phoneNumber',value),
                     decoration:InputDecoration(
                       prefixIcon: Icon(Iconsax.mobile),
                       labelText: "Phone",
                     ),
                   ),
                   ///space
                   SizedBox(height: USizes.spaceBtwItems,),
                 
                   //Street //Postal Code
                   Row(
                     children: [
                       //street
                       Expanded(
                         child: TextFormField(
                           controller: addressController.street,
                           validator: (value)=>UValidator.validateEmptyText('street', value),
                           decoration:InputDecoration(
                             prefixIcon: Icon(Iconsax.building_31),
                             labelText: "Street",
                           ),
                         ),
                       ),
                       ///space
                       SizedBox(width: USizes.spaceBtwItems,),

                       //postal code
                       Expanded(
                         child: TextFormField(
                           controller: addressController.postalCode,
                           validator: (value)=>UValidator.validateEmptyText('postalCode', value),
                           decoration:InputDecoration(
                             prefixIcon: Icon(Iconsax.code),
                             labelText: "Postal Code",
                           ),
                         ),
                       ),
                     ],
                   ),
                 
                   ///space
                   SizedBox(height: USizes.spaceBtwItems,),

                   //City //State
                   Row(
                     children: [

                       //City
                       Expanded(
                         child: TextFormField(
                           controller: addressController.city,
                           validator: (value)=>UValidator.validateEmptyText('City', value),
                           decoration:InputDecoration(
                             prefixIcon: Icon(Iconsax.building),
                             labelText: "City",
                           ),
                         ),
                       ),
                       ///space
                       SizedBox(width: USizes.spaceBtwItems,),

                       //State
                       Expanded(
                         child: TextFormField(
                           controller: addressController.state,
                           validator: (value)=>UValidator.validateEmptyText('state', value),
                           decoration:InputDecoration(
                             prefixIcon: Icon(Iconsax.activity),
                             labelText: "State",
                           ),
                         ),
                       ),
                 
                     ],
                   ),
                 
                   ///space
                   SizedBox(height: USizes.spaceBtwItems,),

                   //Country
                   TextFormField(
                     controller: addressController.country,
                     validator: (value)=>UValidator.validateEmptyText('Country', value),
                     decoration:InputDecoration(
                       prefixIcon: Icon(Iconsax.global),
                       labelText: "Country",
                     ),
                   ),
                 
                   ///space
                   SizedBox(height: USizes.spaceBtwSections,),
                 
                   //Save Button
                   UElevatedButton(
                       onPressed: (){
                         addressController.addNewAddress();

                       },
                       child: Text("Save"),
                   ),
                 
                 ],
                              ),
               ),
           ),
         ),
    );
  }
}
