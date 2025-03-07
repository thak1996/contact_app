import 'package:contact_app/android/view/widgets/drawer.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/post.controller.dart';
import 'widgets/app_bar.widget.dart';
import 'widgets/post.listtile.dart';

class PostView extends StatelessWidget {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostController()..fetchPosts(),
      child: Scaffold(
        appBar: AppBarWidget(title: 'Posts'),
        drawer: DrawerWidget(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<PostController, PostState>(
              builder: (context, state) {
                switch (state) {
                  case PostLoading():
                    return Center(child: CircularProgressIndicator());
                  case PostLoaded():
                    return Expanded(
                      child: SingleChildScrollView(
                        child: RefreshIndicator(
                          onRefresh: () async => await context //
                              .read<PostController>()
                              .fetchPosts(),
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.posts.length,
                            itemBuilder: (context, index) {
                              final post = state.posts[index];
                              return PostListTile(post: post);
                            },
                          ),
                        ),
                      ),
                    );
                  case PostError():
                    return Center(child: Text('Erro: ${state.message}'));
                  default:
                    return Center(child: Text('Erro desconhecido'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
