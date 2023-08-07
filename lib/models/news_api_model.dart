class NewsSource {
  final String id;
  final String name;
  const NewsSource({required this.id, required this.name});

  factory NewsSource.fromJSON(Map<String, dynamic> json) =>
      NewsSource(id: json['id'], name: json['name']);

  Map<String, dynamic> toJSON() => {'id': id, 'name': name};
}

class NewsApiModel {
  final NewsSource source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  const NewsApiModel(
      {required this.source,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content});

  factory NewsApiModel.fromJSON(Map<String, dynamic> json) => NewsApiModel(
      source: NewsSource.fromJSON(json['source']),
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content']);

  Map<String, dynamic> toJSON() => {
        'source': source.toJSON(),
        'author': author,
        'title': title,
        'description': description,
        'url': url,
        'urlToImage': urlToImage,
        'publishedAt': publishedAt,
        'content': content
      };
}
