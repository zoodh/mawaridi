import 'package:mawaridii/features/products/models/review.dart';
class Product {
  final String id;
  final String name;
  final String description;
  final String imagePath;
  final List<String> galleryImages;
  final String price;
  final String brand;
  final int categoryId;
  final double rating;
  final int stock;
  final int reviewCount;
  final int salePercentage;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.brand,
    required this.galleryImages,
    required this.price,
    required this.categoryId,
    required this.rating,
    required this.stock,
    required this.reviewCount,
    this.salePercentage = 0,
  });

  double get discountedPrice {
    final originalPrice = double.tryParse(price) ?? 0;
    return originalPrice * (1 - salePercentage / 100);
  }

  bool get isOnSale => salePercentage > 0;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imagePath': imagePath,
      'brand': brand,
      'galleryImages': galleryImages,
      'price': price,
      'categoryId': categoryId,
      'rating': rating,
      'stock': stock,
      'reviewCount': reviewCount,
      'salePercentage': salePercentage,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imagePath: json['imagePath'] ?? '',
      brand: json['brand'] ?? '',
      galleryImages: List<String>.from(json['galleryImages'] ?? []),
      price: json['price'] ?? '0.0',
      categoryId: json['categoryId'] ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] ?? 0,
      reviewCount: json['reviewCount'] ?? 0,
      salePercentage: json['salePercentage'] ?? 0,
    );
  }
}
