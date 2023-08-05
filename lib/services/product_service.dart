import 'dart:convert';

import 'package:fluttertestapp/models/product_response_wrapper.dart';
import 'package:fluttertestapp/models/product_review_model.dart';
import 'package:http/http.dart' as http;

Future<List<ProductReviewModel>> fetchMoreReviews(
    int page_no, int page_size) async {
  var uri =
      "https://dummyjson.com/quotes?limit=$page_size&skip=${(page_no - 1) * page_size}";
  var response = await http.get(Uri.parse(uri));
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    var quotes = (body['quotes'] as List<dynamic>)
        .map((e) => {
              'username': 'testuser',
              'review': e['quote'],
              'reviewedon': DateTime.now().toString()
            })
        .toList();
    var result = quotes.map((e) => ProductReviewModel.fromJSON(e)).toList();
    return result;
  }
  throw Exception('failed to fetch more reviews');
}

Future<ProductResponseWrapper> fetchProducts() async {
  try {
    var uri = "https://dummyjson.com/products?limit=10";
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var products = body['products'] as List<dynamic>;
      for (var product in products) {
        var url = "https://dummyjson.com/quotes?limit=10";
        var iresponse = await http.get(Uri.parse(url));
        if (iresponse.statusCode == 200) {
          var ibody = jsonDecode(iresponse.body);
          product['reviews'] = (ibody['quotes'] as List<dynamic>)
              .map((e) => {
                    'username': 'testuser',
                    'review': e['quote'],
                    'reviewedon': DateTime.now().toString()
                  })
              .toList();
        } else {
          throw Exception('failed to fetch reviews');
        }
      }
      body['products'] = products;
      var result = ProductResponseWrapper.fromJSON(body);
      return result;
    }
    throw Exception('failed to fetch products');
  } catch (e) {
    print(e.toString());
    throw e;
  }
}
