part of 'pagination_bloc.dart';

@immutable
abstract class PaginationEvent {}

class PaginatonEvents extends PaginationEvent {
  @override
  List<Object> get props => [];
}

class PaginationLoadDataNew extends PaginationEvent {
  @override
  List<Object> get props => [];
}

class PaginationLoadOldData extends PaginationEvent {
  @override
  List<Object> get props => [];
}
