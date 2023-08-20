part of 'posts_bloc_bloc.dart';

abstract class PostsBlocEvent extends Equatable {
  const PostsBlocEvent();
  @override
  List<Object> get props => [];
}

class GetAllPosts extends PostsBlocEvent {}

class RefreshPostEvent extends PostsBlocEvent {}
