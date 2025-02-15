import 'package:flutter/material.dart';

import '../../models/post.model.dart';

class PostListTile extends StatelessWidget {
  const PostListTile({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.title),
      subtitle: Text(post.body),
      leading: CircleAvatar(
        child: Text(post.id.toString()),
      ),
    );
  }
}
