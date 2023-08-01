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
      required this.images});

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
        images: json['images'].toString().split(",").toList());
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
        'images': images.join(",").toString()
      };
}
