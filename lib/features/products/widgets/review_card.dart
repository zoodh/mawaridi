
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mawaridii/features/products/logic/providers/review_rating_provider.dart';
import '../models/review.dart';

class RatingSummaryCard extends ConsumerWidget {
  final List<Review> reviews;

  const RatingSummaryCard({super.key, required this.reviews});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final average =  ref.read(averageRatingProvider(reviews));

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F4F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            average.toStringAsFixed(1),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Icon(
                index < average.round()
                    ? Icons.star
                    : Icons.star_border,
                color: Colors.amber,
                size: 14,
              );
            }),
          ),
          const SizedBox(height: 4),
          Text(
            'product.rating.title'.tr(),
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}



