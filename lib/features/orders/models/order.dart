import '../../products/models/product.dart';
class Order {
  final String corporationName;
  final int quantity;
  final DateTime date;
  final Product product;
  final String corporationPhoneNumber;
  final String address;
  final String clientName;
  final String clientEmail;

  Order({
    required this.corporationName,
    required this.quantity,
    required this.date,
    required this.product,
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
      product: Product.fromJson(json['product'] ?? {}),
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
      'product': product.toJson(),
      'corporationPhoneNumber': corporationPhoneNumber,
      'address': address,
      'clientName': clientName,
      'clientEmail': clientEmail,
    };
  }
}
