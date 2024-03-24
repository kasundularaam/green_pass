import 'package:flutter/material.dart';

class CustomPaymentMethodButton extends StatelessWidget {
  final String methodName;
  final String imageURL;
  final bool isSelected;
  final Function(bool) onSelect;

  const CustomPaymentMethodButton(
      {super.key,
      required this.isSelected,
      required this.onSelect,
      required this.methodName,
      required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          onSelect(true);
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: Theme.of(context)
                  .colorScheme
                  .outlineVariant), // Black outline
          color: isSelected
              ? Theme.of(context).colorScheme.secondaryContainer
              : Theme.of(context).colorScheme.surface, // Filled color
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                methodName,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  imageURL,
                  width: 40,
                  height: 40,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
