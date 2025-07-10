import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mawaridii/app/widgets/stylized_filled_button.dart';
import 'package:mawaridii/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../products/widgets/product_grid.dart';
import '../../products/models/product.dart';
import '../logic/cart_provider.dart';
import '../widgets/summary_widgets.dart';
class CartView extends ConsumerWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final double itemsTotal = cartItems.fold(
      0.0,
          (total, item) => total + (double.tryParse(item.product.price) ?? 0.0) * item.quantity,
    );
    const double deliveryFee = 10.0;
    const double tax = 20.0;
    double grandTotal = itemsTotal + deliveryFee + tax;

    return Scaffold(
      appBar: AppBar(
        title: Text('cart.title'.tr()),
        centerTitle: true,
      ),
      body: cartItems.isEmpty
          ? Center(child: Text('cart.empty'.tr()))
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          final product = item.product;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Stack(
              children: [
                // Product container
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(top: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade600),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${product.price} ر.س',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'cart.quantity'.tr(args: ['${item.quantity}']),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        product.imagePath,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: -10,
                  child: IconButton(
                    icon: const Icon(Icons.delete, size: 20),
                    onPressed: () {
                      ref.read(cartProvider.notifier).removeFromCart(product.id);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CartSummary(
            itemsTotal: itemsTotal,
            tax: tax,
            deliveryFee: deliveryFee,
            grandTotal: grandTotal,
          ),
          StylizedButton(
            text: 'cart.proceed_to_payment'.tr(),
            function: () {
              context.goNamed(AppRoute.checkout.name);
            },
            buttonColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            isBottomSheet: true,
          ),
        ],
      ),
    );
  }
}
