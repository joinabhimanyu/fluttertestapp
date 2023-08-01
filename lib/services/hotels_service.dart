import 'dart:convert';

import 'package:http/http.dart' as http;

Future<dynamic> fetchHotels() async {
  var uri = "https://moviesdatabase.p.rapidapi.com/titles/x/upcoming";
  var response = await http.get(Uri.parse(uri), headers: {
    'X-RapidAPI-Key': 'c7a90dea48mshd98559943487bd9p1480b4jsnfcc2a47f464d',
    'X-RapidAPI-Host': 'moviesdatabase.p.rapidapi.com'
  });
  if (response.statusCode == 200) {
    print('hotels response: ${response.body}');
    var body = jsonDecode(response.body);
    return body;
  } else {
    print('failed to fetch hotels');
  }
  //throw Exception("failed to fetch hotels data");
}
