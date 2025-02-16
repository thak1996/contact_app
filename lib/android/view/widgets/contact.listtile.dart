import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/contact.model.dart';

class ContactListTile extends StatelessWidget {
  const ContactListTile({
    super.key,
    required this.contact,
  });

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Icon(Icons.person)),
      title: Text(
        contact.name,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      subtitle: Text(contact.email, style: TextStyle(fontSize: 12)),
      onTap: () => context.push('/contact_detail', extra: contact),
    );
  }
}
