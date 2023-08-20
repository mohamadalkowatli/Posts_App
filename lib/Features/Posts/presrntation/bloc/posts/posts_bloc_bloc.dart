// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:posts_app/Features/Posts/domain/useases/getAllPostUseCase.dart';
import 'package:posts_app/core/class/error/faliluerMessage.dart';

import '../../../../../core/class/error/failure.dart';
import '../../../domain/entities/post.dart';

part 'posts_bloc_event.dart';
part 'posts_bloc_state.dart';

class PostsBloc extends Bloc<PostsBlocEvent, PostsBlocState> {
  GetAllPostsUseCase getAllPosts;
  PostsBloc({
    required this.getAllPosts,
  }) : super(PostsBlocInitial()) {
    on<PostsBlocEvent>((event, emit) async {
      if (event is GetAllPosts) {
        emit(PostsLoadingState());

        final postOrFailure = await getAllPosts.call();

        print(postOrFailure);

        emit(_mapPostOrFailure(postOrFailure));
      } else if (event is RefreshPostEvent) {
        emit(PostsLoadingState());

        final postOrFailure = await getAllPosts.call();
        emit(_mapPostOrFailure(postOrFailure));
      }
    });
  }
}

PostsBlocState _mapPostOrFailure(Either<Failure, List<Post>> either) {
  return either.fold((failure) {
    final message = _mapFailureToMessage(failure);
    return ErrorState(message);
  }, (posts) => LoadedPostsState(posts: posts));
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case OfflineFailure:
      return OFFLINE_FAILURE_MESSAGE;
    case EmptyCacheFailure:
      return EMPTY_CACHE_FAILURE_MESSAGE;

    default:
      return 'Unexpected Error,Please try again later...';
  }
}
