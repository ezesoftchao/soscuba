import 'package:soscuba/models/cards.dart';
import 'package:soscuba/utils/enc.dart';

class GetPosts {
  final dynamic response;
  GetPosts({required this.response});

  Map<String, dynamic>? data;

  List<dynamic> id = [];
  List<dynamic> author = [];
  List<dynamic> authorImg = [];
  List<dynamic> date = [];
  List<dynamic> text = [];
  List<dynamic> img = [];
  List<dynamic> type = [];
  List<dynamic> verified = [];
  List<dynamic> likes = [];
  List<dynamic> comments = [];
  List<dynamic> shares = [];
  List<dynamic> platform = [];

  Future<List<Post>> execute() async {
    data = this.response;
    final id = [];
    final author = [];
    final authorImg = [];
    final date = [];
    final text = [];
    final img = [];
    final type = [];
    final verified = [];
    final likes = [];
    final comments = [];
    final shares = [];
    final platform = [];

    for (var word in data!['posts']) {
      id.add(word['id']);
      author.add(word['author']);
      authorImg.add(word['author_img']);
      date.add(word['date']);
      text.add(word['text']);
      img.add(word['img']);
      type.add(word['type']);
      verified.add(word['date']);
      likes.add(word['likes']);
      comments.add(word['comments']);
      shares.add(word['shares']);
      platform.add(word['platform']);
    }

    final List<Post> listPost = this._parseProduct(
      id,
      author,
      authorImg,
      date,
      text,
      img,
      type,
      verified,
      likes,
      comments,
      shares,
      platform,
    );

    return listPost;
  }

  List<Post> _parseProduct(
      List<dynamic> id,
      List<dynamic> author,
      List<dynamic> author_img,
      List<dynamic> date,
      List<dynamic> text,
      List<dynamic> img,
      List<dynamic> type,
      List<dynamic> verified,
      List<dynamic> likes,
      List<dynamic> comments,
      List<dynamic> shares,
      List<dynamic> platform) {
    final List<Post> listPosts = <Post>[];

    for (var index = 0; index < id.length; index++) {
      final String post_id = id[index].toString();
      final String post_author = author[index];
      final String post_author_img = author_img[index];
      final String post_date = date[index];
      final String post_text = text[index];
      final String post_img = img[index];
      final String post_type = type[index];
      final String post_verified = verified[index];
      final String post_likes = likes[index].toString();
      final String post_comments = comments[index].toString();
      final String post_shares = shares[index].toString();
      final String post_platform = platform[index].toString();

      final posts = Post(
        post_id,
        post_author,
        post_author_img,
        post_date,
        post_text,
        post_img,
        post_type,
        post_verified,
        post_likes,
        post_comments,
        post_shares,
        post_platform,
      );
      listPosts.add(posts);
    }

    listPosts.forEach((element) {
      print('Author: ' +
          '${decryp(element.author)}' +
          ' Texto: ' +
          '${decryp(element.text)}' +
          ' Plataforma: ' +
          '${decryp(element.platform)}');
    });

    return listPosts;
  }
}
