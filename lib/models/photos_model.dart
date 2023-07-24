class PhotosModel {
  final String albumId;
  final String id;
  final String title;
  final String url;
  final String thumbnailUrl;

  const PhotosModel(
      {required this.albumId,
      required this.id,
      required this.title,
      required this.url,
      required this.thumbnailUrl});

  factory PhotosModel.fromJSON(Map<String, dynamic> json) {
    return PhotosModel(
        albumId: json['albumId'].toString(),
        id: json['id'].toString(),
        title: json['title'].toString(),
        url: json['url'].toString(),
        thumbnailUrl: json['thumbnailUrl'].toString());
  }

  Map<String, dynamic> toJSON() => {
        'albumId': albumId,
        'id': id,
        'title': title,
        'url': url,
        'thumbnailUrl': thumbnailUrl
      };
}
