import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/Features/Posts/presrntation/bloc/add_post_delete/add_update_delete_bloc_bloc.dart';
import 'package:posts_app/Features/Posts/presrntation/bloc/posts/posts_bloc_bloc.dart';

import 'Features/Posts/presrntation/pages/posts_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//push
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent()),
        ),
        BlocProvider(
          create: (_) => di.sl<AddUpdateDeleteBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const PostsPage(),
      ),
    );
  }
}
