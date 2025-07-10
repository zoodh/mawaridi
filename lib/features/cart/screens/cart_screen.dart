import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mawaridii/app/widgets/stylized_filled_button.dart';
import 'package:mawaridii/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../products/widgets/product_grid.dart';
import '../../products/models/product.dart';
import '../widgets/summary_widgets.dart';
class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> cartProducts = [
      Product(
        id: '1',
        name: 'منتج 1',
        description: 'وصف المنتج 1',
        imagePath: 'assets/images/product-1.png',
        galleryImages: ['assets/images/product-1.png'],
        price: "99.99",
        category: 'عام',
        rating: 4.2,
        stock: 10,
        reviewCount: 10,
        salePercentage: 10, brand: 'kc',
      ),
      Product(
        id: '2',
        name: 'منتج 2',
        description: 'وصف المنتج 2',
        imagePath: 'assets/images/product-2.png',
        galleryImages: ['assets/images/product-2.png'],
        price: "149.50",
        category: 'عام',
        rating: 4.6,
        stock: 7,
        reviewCount: 10,
        salePercentage: 0, brand: 'lc',
      ),
    ];

    double itemsTotal = cartProducts.fold(
      0.0,
          (sum, product) => sum + double.parse(product.price),
    );

    const double deliveryFee = 10.0;
    const double tax = 20.0;
    double grandTotal = itemsTotal + deliveryFee + tax;

    return Scaffold(
      appBar: AppBar(
        title: Text('cart.title'.tr()),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: cartProducts.length,
          itemBuilder: (context, index) {
            final product = cartProducts[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Stack(
                children: [
                  // Product container
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(top: 12), // Add space for icon
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
                                product.price,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'cart.quantity'.tr(args: ['5']),
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

                      },
                    ),
                  ),
                ],
              ),
            );
          }

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
              context.goNamed(
                AppRoute.checkout.name
              );

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
