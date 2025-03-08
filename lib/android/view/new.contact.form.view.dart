import 'package:contact_app/android/core/services/contact.service.dart';
import 'package:contact_app/android/view/widgets/app_bar.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../controller/new.contact.controller.dart';
import '../core/utils/app.validators.dart';
import '../models/contact.model.dart';
import 'widgets/dropdown_button.widget.dart';
import 'widgets/elevated_button.widget.dart';
import 'widgets/teste_form_field.widget.dart';

class NewContact extends StatefulWidget {
  const NewContact({super.key});

  @override
  State<NewContact> createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
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
                switch (state) {
                  case NewContactError():
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
                    break;
                  default:
                    break;
                }
              },
              builder: (context, state) {
                switch (state) {
                  case NewContactLoading():
                    return const Center(child: CircularProgressIndicator());
                  case NewContactLoaded():
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.go('/contact');
                    });
                    return const SizedBox();
                  default:
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Column(
                        spacing: 20,
                        children: [
                          TextFormFieldWidget(
                            controller: _nameController,
                            labelText: 'Nome',
                            validator: AppValidators.validateName,
                          ),
                          TextFormFieldWidget(
                            controller: _emailController,
                            labelText: 'Email',
                            validator: AppValidators.validateEmail,
                          ),
                          DropdownButtonWidget(
                            labelText: "Gênero",
                            value: _selectedGender,
                            onChanged: (value) => setState(
                              () => _selectedGender = value,
                            ),
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
                          ),
                          DropdownButtonWidget(
                            value: _selectedStatus,
                            labelText: 'Status',
                            onChanged: (value) => setState(
                              () => _selectedStatus = value,
                            ),
                            items: [
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
                          ElevatedButtonWidget(
                            text: 'Criar Contato',
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
                          ),
                        ],
                      ),
                    );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
