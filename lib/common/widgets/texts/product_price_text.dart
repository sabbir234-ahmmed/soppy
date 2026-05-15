import 'package:flutter/material.dart';

class UProductPriceText extends StatelessWidget {
  const UProductPriceText({
    super.key,
    this.currentSign = "\$",
    required this.price,
    this.maxLine = 1,
    this.isLarge = false,
    this.lineThrough = false,
  });

  //variable
  final String currentSign, price;
  final int maxLine;
  final bool isLarge, lineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(
      currentSign + price,
      style: isLarge
          ? Theme.of(context).textTheme.headlineMedium!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null,
            )
          : Theme.of(context).textTheme.titleLarge!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null,
            ),
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
    );
  }
}
