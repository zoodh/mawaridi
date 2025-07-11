import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mawaridii/app/widgets/stylized_filled_button.dart';
import 'package:mawaridii/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';
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
    final double grandTotal = itemsTotal + deliveryFee + tax;

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
                      // Product Info
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
                              '${product.price} ${'currency.sar'.tr()}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  'cart.quantity'.tr(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF5F5F5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          final newQty = item.quantity - 1;
                                          ref.read(cartProvider.notifier).changeQuantity(product.id, newQty);
                                        },
                                        child: const Icon(Icons.remove, size: 18, color: Colors.black54),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        item.quantity.toString(),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(width: 8),
                                      GestureDetector(
                                        onTap: () {
                                          ref.read(cartProvider.notifier).changeQuantity(product.id, item.quantity + 1);
                                        },
                                        child: const Icon(Icons.add, size: 18, color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Product Image
                      Image.asset(
                        product.imagePath,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ),
                // Delete icon
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
            text: cartItems.isNotEmpty ?
            'cart.proceed_to_payment'.tr()
            :'cart.empty_checkout'.tr(),
            function: () {
              if(cartItems.isNotEmpty) {
                context.goNamed(AppRoute.checkout.name, extra: cartItems);
              }
              else {
                null;
              }
              },
            buttonColor:
            cartItems.isNotEmpty ?
            Theme.of(context).primaryColor: Colors.grey,
            textColor: Colors.white,
            isBottomSheet: true,
          ),
        ],
      ),
    );
  }
}