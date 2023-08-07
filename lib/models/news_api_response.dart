import 'package:fluttertestapp/models/news_api_model.dart';

class NewsApiResponse {
  final String status;
  final int totalResults;
  final List<NewsApiModel> articles;

  const NewsApiResponse(
      {required this.status,
      required this.totalResults,
      required this.articles});

  factory NewsApiResponse.fromJSON(Map<String, dynamic> json) =>
      NewsApiResponse(
          status: json['status'],
          totalResults: int.parse(json['totalResults'].toString()),
          articles: (json['articles'] as List<dynamic>)
              .map((e) => NewsApiModel.fromJSON(e))
              .toList());

  Map<String, dynamic> toJSON() => {
        'status': status,
        'totalResults': totalResults,
        'articles': articles.map((e) => e.toJSON()).toList()
      };
}
