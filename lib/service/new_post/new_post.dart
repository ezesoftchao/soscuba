import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soscuba/env.dart';

class NewPostHttp {
  Future<Map<String, dynamic>> execute() async {
    final response = await http.post(
      Uri.parse("${Env.URL_PREFIX}/get_post.php"),
    );
    var data = json.decode(response.body);

    return data;
  }
}
