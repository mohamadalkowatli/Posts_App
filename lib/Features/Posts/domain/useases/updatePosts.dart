// ignore: depend_on_referenced_packages
import 'package:dartz/dartz.dart';
import 'package:posts_app/Features/Posts/domain/repositories/reppsitery_Post.dart';
import '../../../../core/class/error/failure.dart';
import '../entities/post.dart';

class UpdatePostUseCase {
  RepositeryPost repositeryPost;

  UpdatePostUseCase(this.repositeryPost);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repositeryPost.updatePosts(post);
  }
}
