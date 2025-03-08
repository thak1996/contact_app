import 'package:contact_app/android/view/widgets/dropdown_button.widget.dart';
import 'package:contact_app/android/view/widgets/elevated_button.widget.dart';
import 'package:contact_app/android/view/widgets/teste_form_field.widget.dart';
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
        spacing: 20,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormFieldWidget(
            labelText: 'Nome',
            controller: nameController,
          ),
          TextFormFieldWidget(
            labelText: 'Email',
            controller: emailController,
          ),
          DropdownButtonWidget(
            value: gender,
            labelText: 'Sexo',
            items: ['Masculino', 'Feminino']
                .map((label) => DropdownMenuItem(
                      value: label,
                      child: Text(label),
                    ))
                .toList(),
            onChanged: (value) => gender = value!,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancelar'),
        ),
        ElevatedButtonWidget(
          text: 'Salvar',
          onPressed: () {
            final updatedContact = contact.copyWith(
              name: nameController.text,
              email: emailController.text,
              gender: gender == 'Masculino' ? 'male' : 'female',
            );
            contactController.updateContact(updatedContact);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
