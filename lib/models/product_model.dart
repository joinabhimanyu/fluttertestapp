import 'package:fluttertestapp/models/product_review_model.dart';

class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final double stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;
  final List<ProductReviewModel> reviews;

  const ProductModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.discountPercentage,
      required this.rating,
      required this.stock,
      required this.brand,
      required this.category,
      required this.thumbnail,
      required this.images,
      required this.reviews});

  factory ProductModel.fromJSON(Map<String, dynamic> json) {
    return ProductModel(
        id: int.parse(json['id'].toString()),
        title: json['title'],
        description: json['description'],
        price: double.parse(json['price'].toString()),
        discountPercentage: double.parse(json['discountPercentage'].toString()),
        rating: double.parse(json['rating'].toString()),
        stock: double.parse(json['stock'].toString()),
        brand: json['brand'],
        category: json['category'],
        thumbnail: json['thumbnail'],
        images: json['images'].toString().split(",").toList(),
        reviews: (json['reviews'] as List<dynamic>)
            .map((e) => ProductReviewModel.fromJSON(e))
            .toList());
  }

  Map<String, dynamic> toJSON() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'discountPercentage': discountPercentage,
        'rating': rating,
        'stock': stock,
        'brand': brand,
        'category': category,
        'thumbnail': thumbnail,
        'images': images.join(",").toString(),
        'reviews': reviews.map((e) => e.toJSON())
      };
}
