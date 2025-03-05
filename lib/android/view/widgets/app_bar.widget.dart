import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    required this.title,
    this.showAddButton = false,
  });



  @override
  Size get preferredSize => const Size.fromHeight(56);

  final String title;
  final bool showAddButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(title),
      centerTitle: true,
      forceMaterialTransparency: true,
      actions: showAddButton ? [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            context.push('/new_contact');
          },
        ),
      ] : null,
    );
  }
}
