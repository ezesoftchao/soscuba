import 'package:soscuba/application/get_post.dart';
import 'package:soscuba/models/cards.dart';
import 'package:soscuba/service/get_posts/get_posts.dart';

class Service {
  Future<List<Post>> getPosts() async {
    final data = await GetPostHttp().execute();

    return await GetPosts(response: data).execute();
  }
}
