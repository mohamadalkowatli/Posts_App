import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app/Features/Posts/data/datasources/postLocalDataSource.dart';
import 'package:posts_app/Features/Posts/data/datasources/postRemoteDataSource.dart';
import 'package:posts_app/Features/Posts/data/repositories/RepositoryPostImp.dart';
import 'package:posts_app/Features/Posts/domain/useases/addPosts.dart';
import 'package:posts_app/Features/Posts/domain/useases/deletePostUseCase.dart';
import 'package:posts_app/Features/Posts/domain/useases/getAllPostUseCase.dart';
import 'package:posts_app/Features/Posts/domain/useases/updatePosts.dart';
import 'package:posts_app/Features/Posts/presrntation/bloc/add_post_delete/add_update_delete_bloc_bloc.dart';
import 'package:posts_app/Features/Posts/presrntation/bloc/posts/posts_bloc_bloc.dart';
import 'package:posts_app/core/class/checkInternet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'Features/Posts/domain/repositories/reppsitery_Post.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - posts

// Bloc

  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(() =>
      AddUpdateDeleteBloc(addPost: sl(), updatePost: sl(), deletePost: sl()));

// Usecases

  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));

// Repository

  sl.registerLazySingleton<RepositeryPost>(() => RepositoryPostImp(
      postsLocalDataSourceImp: sl(),
      postsRemoteDataSourceImp: sl(),
      checkInternet: sl()));

// Datasources

  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostsLocalDataSourceImp(sharedPreferences: sl()));

  sl.registerLazySingleton<PostsRemoteDataSource>(
      () => PostsRemoteDataSourceImp(client: sl()));

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
