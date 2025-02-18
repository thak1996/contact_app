import 'package:contact_app/android/controller/contact.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/contact.model.dart';
import 'widgets/app_bar.widget.dart';
import 'widgets/contact.listtile.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactController()..fetchContacts(),
      child: Scaffold(
        appBar: AppBarWidget(title: 'Contact Page'),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<ContactController, ContactState>(
              builder: (context, state) {
                switch (state.runtimeType) {
                  case const (ContactLoading):
                    return Center(child: CircularProgressIndicator());
                  case const (ContactLoaded):
                    final homeLoadedState = state as ContactLoaded;
                    return Expanded(
                      child: SingleChildScrollView(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await context //
                                .read<ContactController>()
                                .fetchContacts();
                          },
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: homeLoadedState.contacts.length,
                            itemBuilder: (context, index) {
                              final contact = homeLoadedState.contacts[index];
                              return ContactListTile(
                                contact: contact,
                                onDelete: () {
                                  // Lógica para apagar o contato
                                },
                                onEdit: () {
                                  // Lógica para editar o contato
                                  _showEditDialog(context, contact);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  case const (ContactError):
                    final homeErrorState = state as ContactError;
                    return Center(
                      child: Text('Erro: ${homeErrorState.message}'),
                    );
                  default:
                    return Center(
                      child: Text('Clique no botão para carregar os contatos'),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, Contact contact) {
    final TextEditingController nameController =
        TextEditingController(text: contact.name);
    final TextEditingController emailController =
        TextEditingController(text: contact.email);
    String gender = contact.gender == 'male' ? 'Masculino' : 'Feminino';

    showDialog(
      context: context,
      builder: (BuildContext context) {
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
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                // Lógica para salvar as alterações
                contact.copyWith(
                  name: nameController.text,
                  email: emailController.text,
                  gender: gender == 'Masculino' ? 'male' : 'female',
                );
                // context.read<ContactController>().updateContact(updatedContact);
                Navigator.of(context).pop();
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
}
