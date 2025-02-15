import 'package:flutter/material.dart';
import '../models/contact.model.dart';

class ContactDetailView extends StatelessWidget {
  final Contact contact;

  const ContactDetailView({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),
            ),
            SizedBox(height: 16),
            Text.rich(
              TextSpan(
                text: 'Nome: ',
                style: TextStyle(fontSize: 14),
                children: [
                  TextSpan(
                    text: contact.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text: 'Email: ',
                style: TextStyle(fontSize: 14),
                children: [
                  TextSpan(
                    text: contact.email,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text: 'Gênero: ',
                style: TextStyle(fontSize: 14),
                children: [
                  TextSpan(
                    text: contact.gender,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text: 'Status: ',
                style: TextStyle(fontSize: 14),
                children: [
                  TextSpan(
                    text: contact.status,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
