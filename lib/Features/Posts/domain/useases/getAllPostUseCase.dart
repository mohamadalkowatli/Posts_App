import 'package:dartz/dartz.dart';

import '../../../../core/class/error/failure.dart';
import '../entities/post.dart';
import '../repositories/reppsitery_Post.dart';

class GetAllPostsUseCase {
  RepositeryPost repositeryPost;

  GetAllPostsUseCase(
    this.repositeryPost,
  );

  Future<Either<Failure, List<Post>>> call() async {
    return await repositeryPost.getAllPosts();
  }
}
