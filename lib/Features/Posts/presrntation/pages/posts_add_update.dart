import 'package:flutter/material.dart';
import 'package:posts_app/Features/Posts/domain/entities/post.dart';

class PostsAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;
  const PostsAddUpdatePage({super.key, this.post, required this.isUpdatePost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: isUpdatePost == true
              ? const Text("update post")
              : const Text("Add Post")),
    );
  }
}
