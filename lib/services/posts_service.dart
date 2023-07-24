import 'dart:convert';
import 'dart:math';
import 'package:fluttertestapp/models/posts_model.dart';
import 'package:http/http.dart' as http;

Future<List<PostsModel>> getPosts(String? searchparam) async {
  const String uri = "https://jsonplaceholder.typicode.com/posts";
  final response = await http.get(Uri.parse(uri));
  if (response.statusCode == 200) {
    final List<PostsModel> postModel = [];
    var body = jsonDecode(response.body);
    if (body.isNotEmpty) {
      if (searchparam!.isNotEmpty) {
        body.retainWhere(
            (element) => element['body'].toString().contains(searchparam));
      }
      var random = Random();
      body.asMap().forEach((index, record) {
        record['title'] =
            "https://source.unsplash.com/random/200x200?sig=${index + random.nextInt(100)}";
      });
      for (var element in body) {
        postModel.add(PostsModel.fromJSON(element));
      }
    }
    return postModel;
  } else {
    throw Exception('Failed to load resource');
  }
}
