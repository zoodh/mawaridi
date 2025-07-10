
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logic/providers/quantity_provider.dart';

class QuantitySelectorWithDiscount extends ConsumerWidget {

  const QuantitySelectorWithDiscount({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = ref.watch(quantityProvider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: const [
              Text(
                "العلامة التجارية",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                "كهف اند كيه فرينج",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        const Text(
          "خصم %20",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (quantity > 1) {
                    ref.read(quantityProvider.notifier).state--;
                  }
                },
                child: const Icon(Icons.remove, color: Colors.black54),
              ),
              const SizedBox(width: 12),
              Text(
                quantity.toString(),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  ref.read(quantityProvider.notifier).state++;
                },
                child: const Icon(Icons.add, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }

}

