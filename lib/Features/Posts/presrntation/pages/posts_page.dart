import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/Features/Posts/presrntation/bloc/posts/posts_bloc_bloc.dart';
import 'package:posts_app/Features/Posts/presrntation/widgets/error_widget.dart';
import 'package:posts_app/core/widget/loadingWidget.dart';

import '../../../../core/widget/appBar.dart';
import '../widgets/posts_list_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('posts'),
      floatingActionButton: _buildFloatingBtn(context),
      body: _bulidBody(),
    );
  }
}

Widget _buildFloatingBtn(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {},
    child: const Icon(Icons.add),
  );
}

Widget _bulidBody() {
  return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsBlocState>(builder: (context, state) {
        if (state is PostsLoadingState) {
          return const LoadingWidget();
        } else if (state is ErrorState) {
          return ErrorMessageWidget(message: state.message);
        } else if (state is LoadedPostsState) {
          return RefreshIndicator(
            child: PostsList(posts: state.posts),
            onRefresh: () => _onRefresh(context),
          );
        } else {
          return const LoadingWidget();
        }
      }));
}

Future<void> _onRefresh(BuildContext context) async {
  BlocProvider.of<PostsBloc>(context).add(RefreshPostEvent());
}
