import 'dart:convert';

import 'package:fluttertestapp/models/news_api_response.dart';
import 'package:http/http.dart' as http;

Future<NewsApiResponse> fetchNewsApiDetails({String country = "in"}) async {
  var uri =
      "https://newsapi.org/v2/top-headlines?country=${country}&apiKey=a89508c38a3a425c8e2331c2081faaf5";
  var response = await http.get(Uri.parse(uri));
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    var result = NewsApiResponse.fromJSON(body);
    return result;
  }
  throw Exception('failed to fetch News Api');
}
