//if reviews are seprate from products
import 'package:flutter/material.dart';
import 'package:mawaridii/features/products/widgets/star_rating.dart';
import '../logic/providers/review_rating_provider.dart';
import '../models/review.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class RatingBreakdown extends ConsumerWidget {
  final List<Review> reviews;

  const RatingBreakdown({super.key, required this.reviews});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counts = ref.watch(ratingCountsProvider(reviews));

    return Column(
      children: List.generate(5, (i) {
        final rating = 5 - i;
        final count = counts[rating - 1];
        final total = reviews.length;
        final percent = total == 0 ? 0.0 : count / total;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              SizedBox(
                width: 35,
                child: Text(
                  "${(percent * 100).toStringAsFixed(0)}%",
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: LinearProgressIndicator(
                  value: percent,
                  borderRadius: BorderRadius.circular(10),
                  minHeight: 7,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
              const SizedBox(width: 8),
              StarDisplay(filledStars: rating, size: 14),
              const SizedBox(width: 4),
              Text("($count)", style: const TextStyle(fontSize: 12)),
            ],
          ),
        );
      }),
    );
  }
}
