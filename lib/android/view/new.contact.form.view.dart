import 'package:contact_app/android/core/services/contact.service.dart';
import 'package:contact_app/android/view/widgets/app_bar.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../controller/new.contact.controller.dart';
import '../core/utils/app.validators.dart';
import '../models/contact.model.dart';

class NewContact extends StatefulWidget {
  const NewContact({super.key});

  @override
  State<NewContact> createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  String? _selectedGender;
  String? _selectedStatus;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewContactController(ContactService()),
      child: Scaffold(
        appBar: AppBarWidget(title: "New Contact"),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: BlocConsumer<NewContactController, NewContactState>(
              listener: (context, state) {
                if (state is NewContactError) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Erro'),
                        content: Text(state.message),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () => context.pop(),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              builder: (context, state) {
                if (state is NewContactLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return Column(children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Nome'),
                    validator: AppValidators.validateName,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: AppValidators.validateEmail,
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedGender,
                    decoration: const InputDecoration(labelText: 'Gênero'),
                    items: const [
                      DropdownMenuItem(
                        value: 'male',
                        child: Text('Masculino'),
                      ),
                      DropdownMenuItem(
                        value: 'female',
                        child: Text('Feminino'),
                      ),
                    ],
                    onChanged: (value) =>
                        setState(() => _selectedGender = value),
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedStatus,
                    decoration: const InputDecoration(labelText: 'Status'),
                    onChanged: (value) =>
                        setState(() => _selectedStatus = value),
                    items: const [
                      DropdownMenuItem(
                        value: 'active',
                        child: Text('Ativo'),
                      ),
                      DropdownMenuItem(
                        value: 'inactive',
                        child: Text('Inativo'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final newContact = Contact(
                          name: _nameController.text,
                          email: _emailController.text,
                          gender: _selectedGender!,
                          status: _selectedStatus!,
                        );
                        context //
                            .read<NewContactController>()
                            .createContact(newContact);
                      }
                    },
                    child: const Text('Criar Contato'),
                  ),
                ]);
              },
            ),
          ),
        ),
      ),
    );
  }
}
