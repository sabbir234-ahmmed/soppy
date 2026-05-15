import 'package:e_commerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:e_commerce/common/widgets/loaders/circular_loader.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/data/repository/address/address_repository.dart';
import 'package:e_commerce/features/personalization/models/address_model.dart';
import 'package:e_commerce/features/personalization/screens/address/widgets/single_address.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_functions.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:e_commerce/utils/popups/snackbar_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, showModalBottomSheet;
import 'package:get/get.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  /// variables
  final name = TextEditingController();
  final phone = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();

  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  final _repository=Get.put(AddressRepository());

  /// for select tapped address
  Rx<AddressModel> selectedAddress= AddressModel.empty().obs;

  /// for refresh Future builder
  RxBool refreshData=false.obs;


  ///-------------- [ADD NEW ADDRESS]-------------------
  Future<void> addNewAddress() async {
    try {
      // start loading
      UFullScreenLoader.openLoadingDialog('Storing Address...');
      // check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        return;
      }

      /// form validation
      if (!addressFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }

      /// create addressModel from this form data
      AddressModel address = AddressModel(
          id: '',
          name: name.text.trim(),
          phoneNumber: phone.text.trim(),
          street: street.text.trim(),
          city: city.text.trim(),
          state: state.text.trim(),
          postalCode: postalCode.text.trim(),
          country: country.text.trim(),
          dateTime: DateTime.now(),
          selectedAddress: true,
      );

      /// invoke repo method to store address on fire store
      String addressId= await _repository.addAddress(address);
      // update address id
      address.id=addressId;

      /// update selected address
      selectAddress(address);

      // stop loading
      UFullScreenLoader.stopLoading();

      //success message
      USnackBarHelpers.successSnackBar(title: "Congratulations",message: "Your Address has been saved successfully");

      // refresh future builder(refresh for showing newly added address )
      refreshData.toggle();

      // reset AddressFormFields
      resetAddressFormFields();

      // go back two time
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);

    } catch (e) {
       throw USnackBarHelpers.errorSnackBar(title: "Failed to Add Address", message:  e.toString());
    }
  }
  /// reset address form
  void resetAddressFormFields(){
   name.clear();
   phone.clear();
   street.clear();
   postalCode.clear();
   city.clear();
   state.clear();
   country.clear();

   addressFormKey.currentState!.reset();
  }

  /// ---------------[GET CURRENT USER ADDRESSES]----------------------
  Future<List<AddressModel>> getAddresses() async{
    try{
     List<AddressModel> addresses= await _repository.fetchAddress();
     selectedAddress.value=addresses.firstWhere((address)=>address.selectedAddress==true, orElse: ()=> AddressModel.empty());
     return addresses;
    }catch (e){
      USnackBarHelpers.errorSnackBar(title: "Empty",message: e.toString());
      return [];
    }
  }

  /// [FUNCTION TO SELECT TAPPED ADDRESS]-------------------
  Future<void> selectAddress(AddressModel newSelectedAddress) async{
   try{

     // start loading
     Get.defaultDialog(
       title: '',
       onWillPop: ()async {
         return false;
       },
       barrierDismissible: false,
       backgroundColor: Colors.transparent,
       content: UCircularLoader(),
     );

     /// unselect the already selected address
     if(selectedAddress.value.id.isNotEmpty){
       print("------------------under selected address unselected-------------ID:${selectedAddress.value.id}");
       await _repository.updateSelectedField(selectedAddress.value.id, false);
     }

     /// select the new one
     newSelectedAddress.selectedAddress=true;
     selectedAddress.value=newSelectedAddress;

     /// set selectedAddress field true on fire store for newSelected address
     await _repository.updateSelectedField(selectedAddress.value.id, true);

     // stop loading
     Get.back();


   }catch (e){
     // stop loading
     Get.back();
     throw USnackBarHelpers.errorSnackBar(title: "Failed", message: e.toString());
   }
  }


  /// SELECT NEW ADDRESSS BOTTOM SHEET
  Future <void> selectNewAddressBottomSheet (BuildContext context)async{
    return showModalBottomSheet(context: context,
        builder: (context)=>SingleChildScrollView(
          padding: EdgeInsets.all(USizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              USectionHeading(title: "Select Address",showButton: false,),
              SizedBox(height: USizes.spaceBtwSections,),
              FutureBuilder(
                  future: getAddresses(),

                  builder: (context, snapshot){
                       // handle error, state, empty
                       final widget= UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                       if(widget!=null){
                         return widget;
                       }
                       final addresses= snapshot.data;

                     return ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          return  USingleAddress(
                              address: addresses[index],
                              onTap: (){
                                selectAddress(addresses[index]);
                                Get.back();
                              }
                          );
                        },
                        separatorBuilder: (context,index){
                          return SizedBox(height: USizes.spaceBtwItems,);
                        },
                        itemCount: addresses!.length,
                    );
                  }
              ),

            ],
          ),
        ));
  }

}