import 'package:fluttertestapp/models/product_model.dart';

class ProductResponseWrapper {
  final List<ProductModel> products;
  final double total;
  final double skip;
  final double limit;

  const ProductResponseWrapper(
      {required this.products,
      required this.total,
      required this.skip,
      required this.limit});

  factory ProductResponseWrapper.fromJSON(Map<String, dynamic> json) {
    return ProductResponseWrapper(
        products: (json['products'] as List<dynamic>)
            .map((e) => ProductModel.fromJSON(e))
            .toList(),
        total: double.parse(json['total'].toString()),
        skip: double.parse(json['skip'].toString()),
        limit: double.parse(json['limit'].toString()));
  }

  Map<String, dynamic> toJSON() => {
        'products': products.map((e) => e.toJSON()).toList(),
        'total': total,
        'skip': skip,
        'limit': limit
      };
}
