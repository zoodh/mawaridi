
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../logic/providers/quantity_provider.dart';
import '../models/review.dart';

class RatingSummaryCard extends StatelessWidget {
  final List<Review> reviews;

  const RatingSummaryCard({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    final average = reviews.isEmpty
        ? 0.0
        : reviews.map((r) => r.rating).reduce((a, b) => a + b) / reviews.length;

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

//if reviews are seprate from products
class RatingBreakdown extends StatelessWidget {
  final List<Review> reviews;

  const RatingBreakdown({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    final total = reviews.length;
    final counts = List.generate(5, (i) => 0);

    for (var review in reviews) {
      final idx = review.rating.floor().clamp(1, 5) - 1;
      counts[idx]++;
    }

    return Column(
      children: List.generate(5, (i) {
        final rating = 5 - i;
        final count = counts[rating - 1];
        final percent = total == 0 ? 0.0 : count / total;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              SizedBox(
                width: 35,
                child: Text("${(percent * 100).toStringAsFixed(0)}%",
                    style: const TextStyle(fontSize: 12)),
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
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 14,
                  );
                }),
              ),
            ],
          ),
        );
      }),
    );
  }
}


