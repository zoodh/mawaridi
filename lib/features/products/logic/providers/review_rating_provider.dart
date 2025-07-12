import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../models/review.dart';
final reviewRatingProvider = StateProvider.family<double, String>((ref, reviewId) {
  return 5.0;
});
final averageRatingProvider = Provider.family<double, List<Review>>((ref, reviews) {
  if (reviews.isEmpty) return 0.0;
  final total = reviews.fold<double>(0.0, (sum, r) => sum + r.rating);
  return total / reviews.length;
});

final ratingCountsProvider = Provider.family<List<int>, List<Review>>((ref, reviews) {
  final counts = List.generate(5, (_) => 0);
  for (var review in reviews) {
    final index = review.rating.floor().clamp(1, 5) - 1;
    counts[index]++;
  }
  return counts;
});
