import 'package:flutter/material.dart';

import 'package:posts_app/Features/Posts/domain/entities/post.dart';

class PostsList extends StatelessWidget {
  final List<Post> posts;
  const PostsList({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(
            posts[index].id.toString(),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          title: Text(
            posts[index].title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            posts[index].body,
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
          onTap: () {},
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          thickness: 1,
        );
      },
    );
  }
}
