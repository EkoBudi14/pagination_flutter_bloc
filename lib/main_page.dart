// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pagination_with_bloc/bloc/pagination_bloc.dart';

import 'model.dart';

class MainPage extends StatelessWidget {
  final scrollController = ScrollController();
  MainPage({Key? key}) : super(key: key);

  void setUpController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<PaginationBloc>(context).add(PaginationLoadDataNew());
        }
        // } else if (scrollController.position.outOfRange) {
        //   BlocProvider.of<PaginationBloc>(context).add(PaginationLoadOldData());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setUpController(context);
    // BlocProvider.of<PaginationBloc>(context).add(PaginationLoadDataNew());

    return Scaffold(
      appBar: AppBar(
        title: Text("Pagination with bloc"),
      ),
      body: BlocBuilder<PaginationBloc, PaginationState>(
        builder: (context, state) {
          if (state is PostLoading && state.isFirstFecth!) {
            return CircularProgressIndicator();
          }

          List<Post> posts = [];
          bool isLoading = false;

          if (state is PostLoading) {
            posts = state.post!;
            isLoading = true;
          } else if (state is PostLoaded) {
            posts = state.posts!;
          }

          return ListView.separated(
              controller: scrollController,
              itemBuilder: (_, index) {
                if (index < posts.length) {
                  return _post(posts[index], context);
                } else {
                  Timer(Duration(milliseconds: 1), () {
                    scrollController
                        .jumpTo(scrollController.position.maxScrollExtent);
                  });

                  return CircularProgressIndicator();
                }
              },
              separatorBuilder: (_, index) {
                return Divider(
                  color: Colors.grey,
                );
              },
              itemCount: posts.length);
        },
      ),
    );
  }

  Widget _post(Post post, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${post.id}. ${post.title}",
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Text(post.body)
        ],
      ),
    );
  }
}
