import 'package:e_commerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:e_commerce/common/widgets/loaders/animation_loader.dart';
import 'package:e_commerce/features/shopping/controllers/order_controller/order_controller.dart';
import 'package:e_commerce/features/shopping/models/order_model.dart';
import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_functions.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UOrdersListItems extends StatelessWidget {
  const UOrdersListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController=Get.put(OrderController());
    final bool dark = UHelperFunction.isDarkMode(context);

    return FutureBuilder(
      future: orderController.getOrders(),
      builder: (context, asyncSnapshot) {
        /// asyncSnapshot hold, futureBuilder state+ orders+ error(if exist)
        final nothingFound= UAnimationLoader(
          text: "No order yet!",
          showActionButton: true,
          actionText: "Let's fill it!",
          animation: UImages.pencilAnimation,
          onActionPressed: ()=>Get.offAll(()=>NavigationMenu()),
        );
        final  widget=UCloudHelperFunctions.checkMultiRecordState(snapshot: asyncSnapshot, nothingFound: nothingFound);

        if(widget!=null){
          return widget;
        }

        // orders found
        final List<OrderModel> orders=asyncSnapshot.data!;

        return  ListView.separated(
              itemBuilder: (context, index){
                final OrderModel order=orders[index];
                return URoundedContainer(
                  padding: EdgeInsets.all(USizes.md),
                  showBorder: true,
                  backgroundColor: dark ? UColors.dark : UColors.light,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //1st row
                      /// icon , texts
                      Row(
                        children: [
                          // ship icon
                          Icon(Iconsax.ship),
                          //space
                          SizedBox(width: USizes.spaceBtwItems/2,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // processing text
                              Text(order.orderStatusText, style: Theme.of(context).textTheme.bodyLarge!.apply(color: UColors.primary, fontWeightDelta: 1),),
                              // Order date
                              Text(order.formattedOrderDate, style: Theme.of(context).textTheme.headlineSmall,),
                            ],
                          ),
                          //space
                          Spacer(),
                          // right arrow
                          IconButton(
                            onPressed: (){

                            },
                            icon: Icon(Iconsax.arrow_right),
                          ),
                        ],
                      ),
                      ///space
                      SizedBox(height: USizes.spaceBtwItems,),

                      //2nd row
                      /// icon , texts  /// icon texts
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                // icon
                                Icon(Iconsax.tag),
                                //space
                                SizedBox(width: USizes.spaceBtwItems/2,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //order text
                                    Text("order", style: Theme.of(context).textTheme.labelMedium ),
                                    // order id
                                    Text(order.id, style: Theme.of(context).textTheme.titleMedium,),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Row(
                              children: [
                                // icon
                                Icon(Iconsax.calendar),
                                //space
                                SizedBox(width: USizes.spaceBtwItems/2,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // shipping Date text
                                    Text("Shipping Date", style: Theme.of(context).textTheme.labelMedium ),
                                    // shipping date
                                    Text(order.formattedDeliveryDate, style: Theme.of(context).textTheme.titleMedium,),
                                  ],
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index){
                return SizedBox(height: USizes.spaceBtwItems,);
              },
              itemCount: orders.length,
          );

      }
    )
      ;
  }
}
