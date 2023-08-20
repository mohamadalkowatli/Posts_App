import 'package:dartz/dartz.dart';

import '../../../../core/class/error/failure.dart';
import '../entities/post.dart';

abstract class RepositeryPost {
  Future<Either<Failure, List<Post>>> getAllPosts();

  Future<Either<Failure, Unit>> deletePosts(int postId);
  Future<Either<Failure, Unit>> updatePosts(Post post);
  Future<Either<Failure, Unit>> addPosts(Post post);
}
