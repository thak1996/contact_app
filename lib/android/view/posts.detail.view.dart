import 'package:flutter/material.dart';
import '../models/post.model.dart';
import 'widgets/app_bar.widget.dart';

class PostDetailView extends StatelessWidget {
  const PostDetailView({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Post id: ${post.id}"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: 'Título: ',
                style: TextStyle(fontSize: 14),
                children: [
                  TextSpan(
                    text: post.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text: 'Corpo: ',
                style: TextStyle(fontSize: 14),
                children: [
                  TextSpan(
                    text: post.body,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Ação de edição
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Editar'),
            ),
          ],
        ),
      ),
    );
  }
}
