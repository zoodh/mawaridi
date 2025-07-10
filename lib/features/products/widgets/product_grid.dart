
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mawaridii/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';

import '../logic/providers/products_provider.dart';
import '../models/product.dart';
class ProductGrid extends ConsumerWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryColor = Theme.of(context).primaryColor;


    ref.listen<AsyncValue<List<Product>>>(
      fetchProductsProvider,
          (previous, next) {
        next.whenOrNull(
          error: (err, _) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('errors.generic'.tr(args: [err.toString()]))),
            );
          },
        );
      },
    );

    final state = ref.watch(fetchProductsProvider);

    return state.when(
      data: (products) {
        return GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 0.75,
          children: products.map((product) {
            return InkWell(
              onTap: () {
                context.goNamed(
                  AppRoute.productDetails.name,
                  extra: product,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Image.asset(
                            product.imagePath,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${product.price} ر.س",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(Icons.add_box, color: primaryColor, size: 32),
                          onPressed: () {},
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('errors.generic'.tr(args: [error.toString()]))),
    );
  }
}
