import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/post.model.dart';

class PostListTile extends StatelessWidget {
  const PostListTile({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => context.push('/post_detail', extra: post),
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Title: ${post.title}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(post.body),
            ],
          ),
        ),
      ),
    );
  }
}
