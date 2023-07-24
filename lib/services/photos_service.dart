import 'dart:convert';
import 'dart:math';
import 'package:fluttertestapp/models/photos_model.dart';
import 'package:http/http.dart' as http;

Future<List<PhotosModel>> getPhotos() async {
  const String uri = "https://jsonplaceholder.typicode.com/photos";
  final response = await http.get(Uri.parse(uri));
  if (response.statusCode == 200) {
    final List<PhotosModel> photosModel = [];
    var body = jsonDecode(response.body);
    if (body.isNotEmpty) {
      var random = Random();
      body.asMap().forEach((index, record) {
        record['thumbnailUrl'] =
            "https://source.unsplash.com/random/200x200?sig=${index + random.nextInt(100)}";
      });
      for (var element in body) {
        photosModel.add(PhotosModel.fromJSON(element));
      }
    }
    return photosModel;
  } else {
    throw Exception('Failed to fetch resource');
  }
}
