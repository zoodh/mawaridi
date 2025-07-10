class Review {
  final String id;
  final String username;
  final String body;
  final double rating;

  const Review({
    required this.id,
    required this.username,
    required this.body,
    required this.rating,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'body': body,
      'rating': rating,
    };
  }

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      body: json['body'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
