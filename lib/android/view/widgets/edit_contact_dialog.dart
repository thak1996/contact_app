import 'package:flutter/material.dart';
import '../../controller/contact.controller.dart';
import '../../models/contact.model.dart';

class EditContactDialog extends StatelessWidget {
  final Contact contact;
  final ContactController contactController;

  const EditContactDialog({
    super.key,
    required this.contact,
    required this.contactController,
  });

  @override
  Widget build(BuildContext context) {
    String gender = contact.gender == 'male' ? 'Masculino' : 'Feminino';
    final TextEditingController nameController = TextEditingController(
      text: contact.name,
    );
    final TextEditingController emailController = TextEditingController(
      text: contact.email,
    );

    return AlertDialog(
      title: Text('Editar Contato'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Nome'),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          DropdownButtonFormField<String>(
            value: gender,
            decoration: InputDecoration(labelText: 'Sexo'),
            items: ['Masculino', 'Feminino']
                .map((label) => DropdownMenuItem(
                      value: label,
                      child: Text(label),
                    ))
                .toList(),
            onChanged: (value) {
              gender = value!;
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            final updatedContact = contact.copyWith(
              name: nameController.text,
              email: emailController.text,
              gender: gender == 'Masculino' ? 'male' : 'female',
            );
            contactController.updateContact(updatedContact);
            Navigator.of(context).pop();
          },
          child: Text('Salvar'),
        ),
      ],
    );
  }
}
