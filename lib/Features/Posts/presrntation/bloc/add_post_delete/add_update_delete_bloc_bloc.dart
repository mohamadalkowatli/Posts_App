import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_app/Features/Posts/domain/useases/addPosts.dart';
import 'package:posts_app/Features/Posts/domain/useases/deletePostUseCase.dart';
import 'package:posts_app/Features/Posts/domain/useases/updatePosts.dart';

import '../../../../../core/class/error/failure.dart';
import '../../../../../core/class/error/faliluerMessage.dart';
import '../../../domain/entities/post.dart';

part 'add_update_delete_bloc_event.dart';
part 'add_update_delete_bloc_state.dart';

class AddUpdateDeleteBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  AddPostUseCase addPost;
  UpdatePostUseCase updatePost;
  DeletePostUseCase deletePost;

  AddUpdateDeleteBloc(
      {required this.addPost,
      required this.updatePost,
      required this.deletePost})
      : super(AddDeleteUpdatePostInitial()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrSuccess = await addPost(event.post);

        emit(_eitherDoneMessageOrErrorState(
            failureOrSuccess, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrSuccess = await updatePost(event.post);

        emit(_eitherDoneMessageOrErrorState(
            failureOrSuccess, UPDATE_SUCCESS_MESSAGE));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrSuccess = await deletePost(event.postId);

        emit(_eitherDoneMessageOrErrorState(
            failureOrSuccess, DELETE_SUCCESS_MESSAGE));
      }
    });
  }
}

AddDeleteUpdatePostState _eitherDoneMessageOrErrorState(
    Either<Failure, Unit> either, String message) {
  return either.fold(
    (failure) => ErrorAddDeleteUpdatePostState(
      message: _mapFailureToMessage(failure),
    ),
    (_) => SuccessAddDeleteUpdatePostState(message: message),
  );
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case OfflineFailure:
      return OFFLINE_FAILURE_MESSAGE;

    default:
      return 'Unexpected Error ,Please try again later...';
  }
}
