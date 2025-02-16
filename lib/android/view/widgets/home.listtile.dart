import 'package:flutter/material.dart';

class HomeListTile extends StatelessWidget {
  const HomeListTile({
    super.key,
    this.leading,
    this.title,
    required this.onTap,
  });

  final IconData? leading;
  final String? title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leading ?? Icons.person_outline),
      title: Text(title ?? 'Name ListTile'),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      tileColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      trailing: const Icon(Icons.arrow_forward_ios_outlined),
    );
  }
}
