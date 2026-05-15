import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/features/shopping/screens/order/widgets/order_list.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          /// ---[app bar]------
          appBar: UAppBar(
            showBackArrow: true,
            title: Text("My Orders", style: Theme.of(context).textTheme.headlineSmall,),


          ),

          /// -----[body]-------
          body: Padding(
            padding: UPadding.screenPadding,
            child: UOrdersListItems(),
          ),
    );
  }
}
