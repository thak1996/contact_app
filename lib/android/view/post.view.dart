import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/post.controller.dart';
import 'widgets/post.listtile.dart';

class PostView extends StatelessWidget {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostController()..fetchPosts(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Post Page'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<PostController, PostState>(
              builder: (context, state) {
                switch (state.runtimeType) {
                  case const (PostLoading):
                    return CircularProgressIndicator();
                  case const (PostLoaded):
                    final homeLoadedState = state as PostLoaded;
                    return Expanded(
                      child: SingleChildScrollView(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await context //
                                .read<PostController>()
                                .fetchPosts();
                          },
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: homeLoadedState.posts.length,
                            itemBuilder: (context, index) {
                              final post = homeLoadedState.posts[index];
                              return PostListTile(post: post);
                            },
                          ),
                        ),
                      ),
                    );
                  case const (PostError):
                    final homeErrorState = state as PostError;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Erro: ${homeErrorState.message}'),
                    );
                  default:
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Erro desconhecido'),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
