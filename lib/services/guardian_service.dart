import 'dart:convert';

import 'package:fluttertestapp/models/guardian_result.dart';
import 'package:fluttertestapp/models/guardian_result_wrapper.dart';
import 'package:http/http.dart' as http;

Future<GuardianResultWrapper> searchGuardianPlatform(
    List<GuardianResult> results,
    int page,
    int pagesize,
    String searchterm) async {
  var url =
      "https://content.guardianapis.com/search?page=${page.toString()}&page-size=${pagesize.toString()}&q=${searchterm}&api-key=test";

  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    if (body != null && body['response'] != null) {
      var response = body['response'];
      if (response != null) {
        var result = GuardianResultWrapper.fromJSON(response);
        result.results.insertAll(0, results);
        return result;
      }
    }
  }
  throw Exception("Error occurred during search Guardian platform");
}
