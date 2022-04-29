// ignore_for_file: unused_local_variable, unnecessary_type_check

import 'package:bloc/bloc.dart';
import 'package:flutter_pagination_with_bloc/model.dart';
import 'package:flutter_pagination_with_bloc/post_repositories.dart';
import 'package:meta/meta.dart';

part 'pagination_event.dart';
part 'pagination_state.dart';

class PaginationBloc extends Bloc<PaginationEvent, PaginationState> {
  final PostsRepository postsRepository;
  int page = 1;
  var oldPost = <Post>[];

  PaginationBloc(this.postsRepository) : super(PaginationInitial()) {
    on<PaginatonEvents>((event, emit) async {
      // TODO: implement event handler

      if (event is PaginatonEvents) {
        List<Post> posts = await postsRepository.fetchPosts(page);
        oldPost = posts;

        // postsRepository.fetchPosts(page).then((newPost) {
        //   page++;

        //   final posts = (state as PostLoading).post!;
        //   posts.addAll(newPost);
        //   emit(PostLoaded(posts: posts));
        // });

        emit(PostLoaded(posts: oldPost));
      }

      // if (state is PostLoading) {
      //   final currentState = state;

      //   var oldPost = <Post>[];
      //   if (currentState is PostLoaded) {
      //     oldPost = currentState.posts!;
      //   }

      //   emit(PostLoading(post: oldPost, isFirstFecth: page == 1));
      //   postsRepository.fetchPosts(page).then((newPost) {
      //     page++;

      //     final posts = (state as PostLoading).post!;
      //     posts.addAll(newPost);
      //     emit(PostLoaded(posts: posts));
      //   });
      // }
    });

    on<PaginationLoadDataNew>((event, emit) async {
      if (event is PaginationLoadDataNew) {
        // List<Post> posts = await postsRepository.fetchPosts(page);

        postsRepository.fetchPosts(page += 1).then((newPost) {
          // page++;

          oldPost.addAll(newPost);
        });
        emit(PostLoaded(posts: oldPost));
      }
    });

    // on<PaginationLoadOldData>((event, emit) async {
    //   if (event is PaginationLoadOldData) {
    //     List<Post> posts = await postsRepository.fetchPosts(page);

    //     postsRepository.fetchPosts(page).then((newPost) {
    //       page--;

    //       posts.addAll(newPost);
    //     });
    //     emit(PostLoaded(posts: posts));
    //   }
    // });
  }
}
