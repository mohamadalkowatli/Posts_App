import 'package:dartz/dartz.dart';
import 'package:posts_app/Features/Posts/domain/repositories/reppsitery_Post.dart';
import '../../../../core/class/error/failure.dart';
import '../entities/post.dart';

class AddPostUseCase {
  RepositeryPost repositeryPost;

  AddPostUseCase(this.repositeryPost);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repositeryPost.addPosts(post);
  }
}
