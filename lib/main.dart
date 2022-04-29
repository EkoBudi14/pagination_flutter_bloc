// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pagination_with_bloc/bloc/pagination_bloc.dart';
import 'package:flutter_pagination_with_bloc/main_page.dart';
import 'package:flutter_pagination_with_bloc/post_repositories.dart';
import 'package:flutter_pagination_with_bloc/services.dart';

void main() {
  runApp(MyApp(
    postsRepository: PostsRepository(PostServices()),
  ));
}

class MyApp extends StatelessWidget {
  final PostsRepository? postsRepository;
  const MyApp({Key? key, this.postsRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PaginationBloc(postsRepository!)..add(PaginatonEvents()),
      child: MaterialApp(
        home: MainPage(),
      ),
    );
  }
}
