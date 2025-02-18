import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/contact.model.dart';

class ContactListTile extends StatelessWidget {
  const ContactListTile({
    super.key,
    required this.contact,
    required this.onDelete,
    required this.onEdit,
  });

  final Contact contact;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(contact.id.toString()),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.blue,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.edit, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          onDelete();
          return true;
        } else if (direction == DismissDirection.endToStart) {
          onEdit();
          return false;
        }
        return false;
      },
      child: ListTile(
        leading: CircleAvatar(child: Icon(Icons.person)),
        title: Text(
          contact.name,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        subtitle: Text(contact.email, style: TextStyle(fontSize: 12)),
        onTap: () => context.push('/contact_detail', extra: contact),
      ),
    );
  }
}
