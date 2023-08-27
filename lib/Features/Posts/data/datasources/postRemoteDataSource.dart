import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app/Features/Posts/data/models/postModel.dart';
import 'package:http/http.dart' as http;
import 'package:posts_app/core/constant/appLink.dart';

import '../../../../core/class/error/exception.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> delete(int postId);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> addPost(PostModel postModel);
}

class PostsRemoteDataSourceImp implements PostsRemoteDataSource {
  final http.Client client;
  Map<String, String> headers = {'content-Type': 'application/json'};

  PostsRemoteDataSourceImp({required this.client});
  @override
  Future<List<PostModel>> getAllPosts() async {
    print(Uri.parse(AppLinks.posts));
    final response =
        await client.get(Uri.parse(AppLinks.posts), headers: headers);

    if (response.statusCode == 200) {
      final List decodedJson = jsonDecode(response.body) as List;
      final List<PostModel> postsList = decodedJson
          .map<PostModel>((postModel) => PostModel.fromJson(postModel))
          .toList();

      return postsList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> delete(int postId) async {
    final id = postId.toString();
    final response = await client.delete(Uri.parse("${AppLinks.posts}/$id"),
        headers: headers);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final id = postModel.id.toString();
    final body = {'title': postModel.title, 'body': postModel.body};
    final response = await client.patch(Uri.parse("${AppLinks.posts}/$id"),
        headers: headers, body: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {'title': postModel.title, 'body': postModel.body};
    final response = await client.post(Uri.parse(AppLinks.posts),
        headers: headers, body: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
