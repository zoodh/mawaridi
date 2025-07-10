
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logic/providers/review_rating_provider.dart';
import '../models/review.dart';

class ReviewList extends StatelessWidget {
  final List<Review> reviews;

  const ReviewList({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 16,
                    child: Text(
                      review.username.isNotEmpty
                          ? review.username
                              .trim()
                              .split(' ')
                              .map((e) => e.isNotEmpty ? e[0] : '')
                              .take(2)
                              .join('.')
                              .toUpperCase()
                          : '?',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          review.username,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: List.generate(
                            5,
                            (i) => Icon(
                              i < review.rating.round()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'product.rating.great_product'.tr(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                review.body,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Divider(color: Colors.grey[300]),
            ],
          ),
        );
      },
    );
  }
}

class AddReviewField extends StatefulWidget {
  final void Function(String title, String body, double rating) onSubmit;

  const AddReviewField({super.key, required this.onSubmit});

  @override
  State<AddReviewField> createState() => _AddReviewFieldState();
}

class _AddReviewFieldState extends State<AddReviewField> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'product.rating.write_review'.tr(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'product.rating.how_is_product'.tr(),
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
          ),
        ),
        const SizedBox(height: 8),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final rating = ref.watch(reviewRatingProvider);
            return Row(
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    ref.read(reviewRatingProvider.notifier).state = index + 1.0;
                  },
                );
              }),
            );
          },
        ),
        const SizedBox(height: 16),
        Text(
          'product.rating.review_title'.tr(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _titleController,
          decoration: InputDecoration(
            hintText: 'product.rating.review_title_hint'.tr(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'product.rating.review_content'.tr(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A3F5F),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _bodyController,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: 'product.rating.review_content_hint'.tr(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {
              final title = _titleController.text.trim();
              final body = _bodyController.text.trim();

              if (title.isNotEmpty && body.isNotEmpty) {
                _titleController.clear();
              }
            },
            child: Text('product.send'.tr()),
          ),
        ),
      ],
    );
  }
}


