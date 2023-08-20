part of 'posts_bloc_bloc.dart';

abstract class PostsBlocState extends Equatable {
  const PostsBlocState();
  @override
  List<Object?> get props => [];
}

class PostsBlocInitial extends PostsBlocState {}

class PostsLoadingState extends PostsBlocState {}

class LoadedPostsState extends PostsBlocState {
  final List<Post> posts;

  const LoadedPostsState({required this.posts});
  @override
  List<Object?> get props => [posts];
}

class ErrorState extends PostsBlocState {
  final String message;

  ErrorState(this.message);
}
