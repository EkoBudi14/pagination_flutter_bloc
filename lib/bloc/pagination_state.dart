part of 'pagination_bloc.dart';

@immutable
abstract class PaginationState {}

class PaginationInitial extends PaginationState {}

class PostLoading extends PaginationState {
  final List<Post>? post;
  final bool? isFirstFecth;

  PostLoading({this.post, this.isFirstFecth = false});
}

class PostLoaded extends PaginationState {
  final List<Post>? posts;
  PostLoaded({this.posts});
}
