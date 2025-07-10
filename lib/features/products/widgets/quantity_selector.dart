
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import '../logic/providers/quantity_provider.dart';

class QuantitySelectorWithDiscount extends ConsumerWidget {
  const QuantitySelectorWithDiscount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = ref.watch(quantityProvider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                'product.brand.title'.tr(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
              Text(
                'product.brand.name'.tr(),
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        Text(
          'product.discount'.tr(args: ['20']),
          style: const TextStyle(
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

