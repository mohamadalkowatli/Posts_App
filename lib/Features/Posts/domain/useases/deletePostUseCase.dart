import 'package:posts_app/Features/Posts/domain/repositories/reppsitery_Post.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/class/error/failure.dart';

class DeletePostUseCase {
  RepositeryPost repositeryPost;

  DeletePostUseCase(this.repositeryPost);

  Future<Either<Failure, Unit>> call(int postId) async {
    return await repositeryPost.deletePosts(postId);
  }
}
