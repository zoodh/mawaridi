import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mawaridii/features/cart/logic/cart_provider.dart';
import 'package:mawaridii/features/products/logic/providers/quantity_provider.dart';
import '../../../app/widgets/stylized_filled_button.dart';
import '../../../routes/routes.dart';
import '../models/product.dart';
import '../models/review.dart';
import '../widgets/quantity_selector.dart';
import '../widgets/review_card.dart';
import '../widgets/review_list.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final List<Review> reviews = [Review(id: "12314124", username: "zood", body: "منتج رائع جدا", rating: 2,),

      Review(id: "12314124", username: "zood", body: "منتج رائع جدا", rating: 2,),
      Review(id: "12314124", username: "zood", body: "منتج رائع جدا", rating: 2,)

      ];
    return Scaffold(
      appBar: AppBar(
        title: Text('product.details'.tr()),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  product.imagePath,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                product.name,
                textAlign: TextAlign.right,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                product.description,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "\$${product.price}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A3A43),
                    ),
                  ),

                  // Review bubble
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F3F6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Text(
                         "${product.reviewCount} ${'product.customer_reviews'.tr()}" ,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF4A3A43),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.chat_bubble_outline, size: 14, color: Color(0xFF4A3A43)),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF5D9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star_border, color: Color(0xFFFFC107), size: 14),
                        const SizedBox(width: 4),
                        Text(
                          product.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFC107),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 6),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'product.recommendation'.tr(args: ['93']),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                  ),
                ),
              ),

              const SizedBox(height: 24),
              QuantitySelector(),
              const SizedBox(height: 24),

              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return StylizedButton(
                    text: 'product.add_to_cart'.tr(),
                    function: () {
                      ref.read(cartProvider.notifier).addToCart(product, ref.read(quantityProvider));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('تمت إضافة المنتج إلى السلة بنجاح'),
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    buttonColor: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    icon: Icons.shopping_bag_outlined,
                    isBottomSheet: true,
                  );
                },
              ),

              SizedBox(height: 20,) ,

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: RatingBreakdown(reviews: reviews),
                    ),
                  const SizedBox(width: 16),
                  RatingSummaryCard(reviews: reviews,),
                ],
              ),
      ReviewList(reviews: reviews),
              SizedBox(height: 10,),
                  AddReviewField(onSubmit: (String title, String body, double rating) {  },)
            ],
          ),
        ),

      ),
    );
  }
}