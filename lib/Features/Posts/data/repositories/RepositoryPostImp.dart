import 'package:dartz/dartz.dart';
import 'package:posts_app/Features/Posts/data/datasources/postRemoteDataSource.dart';
import 'package:posts_app/Features/Posts/data/models/postModel.dart';
import 'package:posts_app/Features/Posts/domain/entities/post.dart';
import 'package:posts_app/Features/Posts/domain/repositories/reppsitery_Post.dart';
import 'package:posts_app/core/class/checkInternet.dart';

import '../../../../core/class/error/exception.dart';
import '../../../../core/class/error/failure.dart';
import '../datasources/postLocalDataSource.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class RepositoryPostImp implements RepositeryPost {
  PostsRemoteDataSourceImp postsRemoteDataSourceImp;

  PostLocalDataSourceImp postLocalDataSourceImp;

  NetworkInfo checkInternet;

  RepositoryPostImp({
    required this.postLocalDataSourceImp,
    required this.postsRemoteDataSourceImp,
    required this.checkInternet,
  });

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await checkInternet.isConnected) {
      try {
        final postRemote = await postsRemoteDataSourceImp.getAllPosts();
        postLocalDataSourceImp.cachePosts(postRemote);
        return Right(postRemote);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final postCached = await postLocalDataSourceImp.getCachedPosts();

        return Right(postCached);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPosts(Post post) async {
    PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _request(() {
      return postsRemoteDataSourceImp.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePosts(int postId) async {
    return await _request(() {
      return postsRemoteDataSourceImp.delete(postId);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePosts(Post post) async {
    PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _request(() {
      return postsRemoteDataSourceImp.updatePost(postModel);
    });
  }

  Future<Either<Failure, Unit>> _request(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async {
    if (await checkInternet.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
