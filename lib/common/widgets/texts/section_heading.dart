import 'package:flutter/material.dart';

class USectionHeading extends StatelessWidget {
  const USectionHeading({
    super.key,
    //this.textColor,
    required this.title,
    this.buttonTittle="View all",
    this.onPressed,
    this.showButton=true,
  });

  //for the purpose of customizing
  //final Color? textColor;
  final String title, buttonTittle;
  final void Function()? onPressed;
  final bool showButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //title
        Text(title, style: Theme.of(context).textTheme.headlineSmall, maxLines: 1, overflow: TextOverflow.ellipsis,),
        //text button
        showButton? TextButton(onPressed: onPressed, child: Text(buttonTittle)) : SizedBox.shrink(),
      ],
    );
  }
}
