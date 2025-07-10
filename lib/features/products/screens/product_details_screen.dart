import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../app/widgets/stylized_filled_button.dart';
import '../../../routes/routes.dart';
import '../models/product.dart';
import '../models/review.dart';

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
                          'product.customer_reviews'.tr(args: [product.reviewCount.toString()]),
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
              QuantitySelectorWithDiscount(quantity: 0, onAdd: (){}, onRemove: (){}),
              const SizedBox(height: 24),

              StylizedButton(
                text: 'product.add_to_cart'.tr(),
                function: () {
                  context.goNamed(AppRoute.checkout.name);
                },
                buttonColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                icon : Icons.shopping_bag_outlined,
                isBottomSheet: true,
              ),
              SizedBox(height: 20,)      ,

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
                  // Avatar
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
                  // Username and stars
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
                  // Time ago

                ],
              ),
              const SizedBox(height: 12),
              // Review body
              Text(
                review.body,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20,),
              Divider(color: Colors.grey[300],)
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
  double _rating = 5.0;

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
          "كيف هو المنتج؟",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < _rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
              onPressed: () {
                setState(() {
                  _rating = index + 1.0;
                });
              },
            );
          }),
        ),
        const SizedBox(height: 16),
        const Text(
          "عنوان المراجعة",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _titleController,
          decoration: InputDecoration(
            hintText: "منتجات رائعة",
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
        const Text(
          "مراجعة المحتوى",
          style: TextStyle(
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
            hintText: "اكتب محتوى المراجعة هنا...",
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
                widget.onSubmit(title, body, _rating);
                _titleController.clear();
                _bodyController.clear();
                setState(() => _rating = 5.0);
              }
            },
            child: Text('product.send'.tr()),
          ),
        ),
      ],
    );
  }
}




class QuantitySelectorWithDiscount extends StatelessWidget {
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const QuantitySelectorWithDiscount({
    Key? key,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                "العلامة التجارية",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
              Text(
                "كهف اند كيه فرينج",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Text(
          "خصم %20",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(width: 16),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: onRemove,
                child: Icon(Icons.remove, color: Colors.black54),
              ),
              SizedBox(width: 12),
              Text(
                quantity.toString(),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(width: 12),
              GestureDetector(
                onTap: onAdd,
                child: Icon(Icons.add, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
