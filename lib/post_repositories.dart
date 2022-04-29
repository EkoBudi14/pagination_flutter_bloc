import 'package:flutter_pagination_with_bloc/model.dart';
import 'package:flutter_pagination_with_bloc/services.dart';

class PostsRepository {
  final PostServices service;

  PostsRepository(this.service);

  Future<List<Post>> fetchPosts(int page) async {
    final posts = await service.fetchPosts(page);
    return posts.map((e) => Post.fromJson(e)).toList();
  }
}
