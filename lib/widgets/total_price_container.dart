import 'package:flutter/material.dart';

class TotalPriceContainer extends StatefulWidget {
  final double totalPrice;
  const TotalPriceContainer({
    super.key,
    required this.totalPrice,
  });

  @override
  State<TotalPriceContainer> createState() => _TotalPriceContainerState();
}

class _TotalPriceContainerState extends State<TotalPriceContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Center(
          child: Text(
            "Total Price : ${widget.totalPrice.toInt()} LKR",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer),
          ),
        ),
      ),
    );
  }
}
