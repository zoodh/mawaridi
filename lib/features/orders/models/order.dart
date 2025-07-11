import '../../products/models/product.dart';
class Order {
  final String corporationName;
  final int quantity;
  final DateTime date;
  final List<Product> products;
  final String corporationPhoneNumber;
  final String address;
  final String clientName;
  final String clientEmail;

  Order({
    required this.corporationName,
    required this.quantity,
    required this.date,
    required this.products,
    required this.corporationPhoneNumber,
    required this.address,
    required this.clientName,
    required this.clientEmail,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      corporationName: json['corporationName'] ?? '',
      quantity: json['quantity'] ?? 0,
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      products: (json['products'] as List<dynamic>? ?? [])
          .map((item) => Product.fromJson(item))
          .toList(),
      corporationPhoneNumber: json['corporationPhoneNumber'] ?? '',
      address: json['address'] ?? '',
      clientName: json['clientName'] ?? '',
      clientEmail: json['clientEmail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'corporationName': corporationName,
      'quantity': quantity,
      'date': date.toIso8601String(),
      'products': products.map((p) => p.toJson()).toList(),
      'corporationPhoneNumber': corporationPhoneNumber,
      'address': address,
      'clientName': clientName,
      'clientEmail': clientEmail,
    };
  }
}
