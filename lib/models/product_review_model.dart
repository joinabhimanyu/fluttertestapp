class ProductReviewModel {
  final String username;
  final String review;
  final DateTime reviewedon;

  const ProductReviewModel(
      {required this.username, required this.review, required this.reviewedon});

  factory ProductReviewModel.fromJSON(Map<String, dynamic> json) =>
      ProductReviewModel(
          username: json['username'],
          review: json['review'],
          reviewedon: DateTime.parse(json['reviewedon']));

  Map<String, dynamic> toJSON() => {
        'username': username,
        'review': review,
        'reviewedon': reviewedon.toString()
      };
}
