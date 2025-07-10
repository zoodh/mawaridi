import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mawaridii/app/logic/bottom_navigation_provider.dart';

class CustomBottomNav extends ConsumerWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);

    final icons = [
      Icons.home_outlined,
      Icons.grid_view,
      Icons.list_alt,
      Icons.shopping_cart_outlined,
      Icons.person_outline,
    ];

    final labels = [
      'navigation.home'.tr(),
      'navigation.building_materials'.tr(),
      'navigation.orders'.tr(),
      'navigation.cart'.tr(),
      'navigation.settings'.tr(),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: const Color(0xFFFBF8F6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(5, (index) {
          final isSelected = currentIndex == index;

          return InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              ref.read(currentIndexProvider.notifier).state = index;
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icons[index],
                  color: isSelected ? const Color(0xFF5D4444) : Colors.black,
                ),
                const SizedBox(height: 4),
                Text(
                  labels[index],
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? const Color(0xFF5D4444) : Colors.black,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
