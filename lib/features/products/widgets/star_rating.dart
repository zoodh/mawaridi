
import 'package:flutter/material.dart';

class StarDisplay extends StatelessWidget {
  final int filledStars;
  final double size;

  const StarDisplay({
    super.key,
    required this.filledStars,
    this.size = 14,
  });

  @override
  Widget build( context) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < filledStars ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: size,
        );
      }),
    );
  }
}