import 'dart:convert';

import 'package:fluttertestapp/models/product_response_wrapper.dart';
import 'package:http/http.dart' as http;

Future<ProductResponseWrapper> fetchProducts() async {
  var uri = "https://dummyjson.com/products";
  var response = await http.get(Uri.parse(uri));
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    var result = ProductResponseWrapper.fromJSON(body);
    return result;
  }
  throw Exception('failed to fetch products');
}
